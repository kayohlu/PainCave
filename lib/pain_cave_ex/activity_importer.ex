defmodule ActivityImporter do
  alias PainCaveEx.Sessions.Session

  def import do
    athlete =
      PainCaveEx.Athletes.list_athletes()
      |> List.first()

    Path.wildcard("/Users/karlgrogan/Downloads/FIT activities/*.fit")
    |> import_files(athlete)
  end

  def import_files([h | t] = files, athlete) do
    file = :fit_parser.parse(h)
    {:ok, records} = file

    create_activity(athlete, records)
    |> create_sessions(athlete, records)
    |> analyze_sessions(records)

    import_files(t, athlete)
  end

  def import_files([], athelte) do
    :ok
  end

  def create_activity(athlete, records) do
    {header, content} =
      Enum.find(
        records,
        fn {header, content} ->
          Map.get(header, 'global_message_number') == 34
        end
      )

    attrs =
      content
      |> Map.take(['timestamp', 'total_timer_time'])
      |> Map.merge(%{
        'total_distance_unit' => "m",
        'total_timer_time_unit' => "s",
        'total_distance' =>
          Enum.filter(
            records,
            fn {header, content} ->
              Map.get(header, 'global_message_number') == 18
            end
          )
          |> Enum.reduce(0, fn {session_header, session_content}, acc ->
            session_content['total_distance'] + acc
          end)
      })

    {:ok, timestamp} = NaiveDateTime.from_erl(Map.get(attrs, 'timestamp'))
    {:ok, timestamp} = DateTime.from_naive(timestamp, "Etc/UTC")

    attrs = Map.put(attrs, 'timestamp', timestamp)

    sessions =
      Enum.filter(
        records,
        fn {header, content} ->
          Map.get(header, 'global_message_number') == 18
        end
      )

    name =
      if Enum.count(sessions) > 1 do
        "Multi sport"
      else
        [first | rest] = sessions
        {head, content} = first
        to_string(content['sport'])
      end

    attrs =
      Map.put(attrs, 'name', name)
      |> Map.put('athlete_id', athlete.id)

    attrs = for {key, val} <- attrs, into: %{}, do: {to_string(key) |> String.to_atom(), val}

    {:ok, activity} =
      attrs
      |> PainCaveEx.Activities.create_activity()

    activity
  end

  def create_sessions(activity, athlete, records) do
    Enum.filter(
      records,
      fn {header, content} ->
        Map.get(header, 'global_message_number') == 18
      end
    )
    |> Enum.map(fn {session_header, session_content} ->
      create_session(activity, athlete, session_content)
    end)
  end

  def create_session(activity, athlete, session_content) do
    attrs =
      for {key, val} <- session_content, into: %{}, do: {to_string(key) |> String.to_atom(), val}

    attrs =
      Enum.reduce(attrs, %{}, fn {key, value}, acc ->
        if Map.get(attrs, key) == :invalid do
          acc
        else
          Map.put(acc, key, value)
        end
      end)
      |> Enum.reduce(%{}, fn {key, value}, acc ->
        if is_list(Map.get(attrs, key)) do
          Map.put(acc, key, to_string(value))
        else
          Map.put(acc, key, value)
        end
      end)
      |> Map.merge(%{
        total_elapsed_time_unit: "s",
        total_distance_unit: "m",
        total_timer_time_unit: "s",
        total_moving_time_unit: "s",
        total_calories_unit: "kcal",
        training_stress_score_unit: "tss",
        intensity_factor_unit: "if",
        avg_speed_unit: "m/s",
        max_speed_unit: "m/s",
        min_heart_rate_unit: "bpm",
        avg_heart_rate_unit: "bpm",
        max_heart_rate_unit: "bpm",
        avg_power_unit: "watts",
        max_power_unit: "watts",
        threshold_power_unit: "watts",
        total_ascent_unit: "m",
        total_descent_unit: "m",
        pool_length_unit: "m",
        stroke_count_unit: "counts",
        avg_stroke_count_unit: "strokes/lap",
        avg_stroke_distance_unit: "m"
      })

    {:ok, timestamp} = NaiveDateTime.from_erl(Map.get(attrs, :timestamp))
    {:ok, timestamp} = DateTime.from_naive(timestamp, "Etc/UTC")

    {:ok, session_start_time} = NaiveDateTime.from_erl(Map.get(attrs, :start_time))
    {:ok, session_start_time} = DateTime.from_naive(session_start_time, "Etc/UTC")

    session_end_time =
      DateTime.add(
        session_start_time,
        trunc(Map.get(attrs, :total_elapsed_time))
      )

    attrs =
      Map.put(attrs, :timestamp, timestamp)
      |> Map.put(:start_time, session_start_time)
      |> Map.put(:end_time, session_end_time)
      |> Map.put(:athlete_id, athlete.id)
      |> Map.put(:activity_id, activity.id)

    attrs
    |> IO.inspect(limit: :infinity, printable_limit: :infinity)

    {:ok, session} = PainCaveEx.Sessions.create_session(attrs)

    session
  end

  def analyze_sessions(sessions, records) do
    Enum.map(sessions, fn session ->
      analyze_session(session)
    end)
  end

  def analyze_session(session) do
    training_load = calculate_session_training_load(session)
    save_session_training_load(session, training_load)

    {atl, ctl, actl} = calculate_acute_chronic_training_load(session)
    save_session_actl(session, actl, atl, ctl)
  end

  def calculate_session_training_load(%Session{sport: "swimming"} = session) do
    # recorded in seconds, so divide by 60 to get mins.
    session.total_timer_time / 60 *
      (session.total_timer_time / session.total_distance)
  end

  def calculate_session_training_load(%Session{sport: "transition"} = session) do
    # recorded in seconds, so divide by 60 to get mins.
    session.total_timer_time / 60 *
      (percentage_heart_rate_reserve(session) *
         0.64 ** (percentage_heart_rate_reserve(session) * 1.92))
  end

  def calculate_session_training_load(%Session{} = session) do
    # recorded in seconds, so divide by 60 to get mins.
    session.total_timer_time / 60 *
      percentage_heart_rate_reserve(session) *
      0.64 ** (percentage_heart_rate_reserve(session) * 1.92)
  end

  def save_session_training_load(session, training_load) do
    {:ok, training_load} =
      PainCaveEx.Sessions.create_training_load(%{
        load: training_load,
        session_id: session.id,
        type: "trimp_exp"
      })
  end

  def percentage_heart_rate_reserve(session) do
    (session.avg_heart_rate - 50) / (max_heart_rate(session) - 50)
  end

  def max_heart_rate(%Session{sport: "cycling"} = session) do
    179
  end

  def max_heart_rate(session) do
    210
  end

  def calculate_acute_chronic_training_load(session) do
    atl = PainCaveEx.Sessions.calculate_atl(session)
    ctl = PainCaveEx.Sessions.calculate_ctl(session)

    {atl, ctl, atl / ctl}
  end

  def save_session_actl(session, actl, atl, ctl) do
    {:ok, actl_record} =
      PainCaveEx.AcuteChronicTrainingLoads.create_acute_chronic_training_load(%{
        session_id: session.id,
        acute_load: atl,
        chronic_load: ctl,
        acute_range: 7,
        chronic_range: 42,
        ratio: actl
      })

    actl_record
  end

  # def x do
  #   session_map =
  #     Enum.reduce(sessions, %{}, fn (session, acc) ->
  #       Map.put_new(acc, session, [])
  #     end)

  #   Enum.filter(records, fn ({header,content}) ->
  #     Map.get(header, 'global_message_number') == 20
  #   end)
  #   |> Enum.reduce(session_map, fn ({record_header, record_content}, acc) ->

  #     sessions_for_record =
  #       Map.keys(acc)
  #       |> Enum.filter(fn (session) ->
  #         IO.inspect(session)
  #         IO.inspect session.start_time
  #         {:ok, session_start_time} = DateTime.from_naive(session.start_time, "Etc/UTC")
  #         {:ok, record_timestamp} = NaiveDateTime.from_erl(record_content['timestamp'])
  #         {:ok, record_timestamp} = DateTime.from_naive(record_timestamp, "Etc/UTC")

  #         session_end_time = DateTime.add(
  #           session_start_time, trunc(session.total_elapsed_time)
  #         )
  #         between(record_timestamp, session_start_time, session_end_time)
  #       end)

  #     Enum.reduce(sessions_for_record, acc, fn (session_for_record, nacc) ->
  #       Map.put(nacc, session_for_record,
  #         Enum.concat(Map.get(nacc, session_for_record), [record_content])
  #       )
  #     end)

  #   end)
  #   |> IO.inspect
  #   # |> Map.keys
  # end

  def between(datetime, datetime_start, datetime_end) do
    Enum.member?([:gt, :eq], DateTime.compare(datetime, datetime_start)) &&
      Enum.member?([:lt, :eq], DateTime.compare(datetime, datetime_end))
  end
end
