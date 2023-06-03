defmodule PainCaveEx.SessionsTest do
  use PainCaveEx.DataCase

  alias PainCaveEx.Sessions

  describe "sessions" do
    alias PainCaveEx.Sessions.Session

    import PainCaveEx.SessionsFixtures

    @invalid_attrs %{
      pool_length: nil,
      avg_power: nil,
      total_descent: nil,
      avg_heart_rate_unit: nil,
      total_elapsed_time: nil,
      stroke_count: nil,
      total_distance: nil,
      avg_stroke_distance_unit: nil,
      avg_heart_rate: nil,
      avg_stroke_count_unit: nil,
      max_heart_rate_unit: nil,
      total_elapsed_time_unit: nil,
      max_heart_rate: nil,
      max_speed_unit: nil,
      avg_stroke_count: nil,
      total_timer_time_unit: nil,
      min_heart_rate_unit: nil,
      max_power: nil,
      total_timer_time: nil,
      total_descent_unit: nil,
      avg_speed: nil,
      total_ascent: nil,
      avg_power_unit: nil,
      pool_length_unit: nil,
      sub_sport: nil,
      total_ascent_unit: nil,
      total_moving_time: nil,
      timestamp: nil,
      total_moving_time_unit: nil,
      max_power_unit: nil,
      avg_speed_unit: nil,
      max_speed: nil,
      sport: nil,
      stroke_count_unit: nil,
      total_distance_unit: nil,
      threshold_power_unit: nil,
      avg_stroke_distance: nil,
      threshold_power: nil,
      min_heart_rate: nil
    }

    test "list_sessions/0 returns all sessions" do
      session = session_fixture()
      assert Sessions.list_sessions() == [session]
    end

    test "get_session!/1 returns the session with given id" do
      session = session_fixture()
      assert Sessions.get_session!(session.id) == session
    end

    test "create_session/1 with valid data creates a session" do
      valid_attrs = %{
        pool_length: 120.5,
        avg_power: 120.5,
        total_descent: 120.5,
        avg_heart_rate_unit: "some avg_heart_rate_unit",
        total_elapsed_time: 120.5,
        stroke_count: 120.5,
        total_distance: 120.5,
        avg_stroke_distance_unit: "some avg_stroke_distance_unit",
        avg_heart_rate: 120.5,
        avg_stroke_count_unit: "some avg_stroke_count_unit",
        max_heart_rate_unit: "some max_heart_rate_unit",
        total_elapsed_time_unit: "some total_elapsed_time_unit",
        max_heart_rate: 120.5,
        max_speed_unit: "some max_speed_unit",
        avg_stroke_count: 120.5,
        total_timer_time_unit: "some total_timer_time_unit",
        min_heart_rate_unit: "some min_heart_rate_unit",
        max_power: 120.5,
        total_timer_time: 120.5,
        total_descent_unit: "some total_descent_unit",
        avg_speed: 120.5,
        total_ascent: 120.5,
        avg_power_unit: "some avg_power_unit",
        pool_length_unit: "some pool_length_unit",
        sub_sport: "some sub_sport",
        total_ascent_unit: "some total_ascent_unit",
        total_moving_time: 120.5,
        timestamp: ~N[2023-05-03 15:44:00],
        total_moving_time_unit: "some total_moving_time_unit",
        max_power_unit: "some max_power_unit",
        avg_speed_unit: "some avg_speed_unit",
        max_speed: 120.5,
        sport: "some sport",
        stroke_count_unit: "some stroke_count_unit",
        total_distance_unit: "some total_distance_unit",
        threshold_power_unit: "some threshold_power_unit",
        avg_stroke_distance: 120.5,
        threshold_power: 120.5,
        min_heart_rate: 120.5
      }

      assert {:ok, %Session{} = session} = Sessions.create_session(valid_attrs)
      assert session.min_heart_rate == 120.5
      assert session.threshold_power == 120.5
      assert session.avg_stroke_distance == 120.5
      assert session.threshold_power_unit == "some threshold_power_unit"
      assert session.total_distance_unit == "some total_distance_unit"
      assert session.stroke_count_unit == "some stroke_count_unit"
      assert session.sport == "some sport"
      assert session.max_speed == 120.5
      assert session.avg_speed_unit == "some avg_speed_unit"
      assert session.max_power_unit == "some max_power_unit"
      assert session.total_moving_time_unit == "some total_moving_time_unit"
      assert session.timestamp == ~N[2023-05-03 15:44:00]
      assert session.total_moving_time == 120.5
      assert session.total_ascent_unit == "some total_ascent_unit"
      assert session.sub_sport == "some sub_sport"
      assert session.pool_length_unit == "some pool_length_unit"
      assert session.avg_power_unit == "some avg_power_unit"
      assert session.total_ascent == 120.5
      assert session.avg_speed == 120.5
      assert session.total_descent_unit == "some total_descent_unit"
      assert session.total_timer_time == 120.5
      assert session.max_power == 120.5
      assert session.min_heart_rate_unit == "some min_heart_rate_unit"
      assert session.total_timer_time_unit == "some total_timer_time_unit"
      assert session.avg_stroke_count == 120.5
      assert session.max_speed_unit == "some max_speed_unit"
      assert session.max_heart_rate == 120.5
      assert session.total_elapsed_time_unit == "some total_elapsed_time_unit"
      assert session.max_heart_rate_unit == "some max_heart_rate_unit"
      assert session.avg_stroke_count_unit == "some avg_stroke_count_unit"
      assert session.avg_heart_rate == 120.5
      assert session.avg_stroke_distance_unit == "some avg_stroke_distance_unit"
      assert session.total_distance == 120.5
      assert session.stroke_count == 120.5
      assert session.total_elapsed_time == 120.5
      assert session.avg_heart_rate_unit == "some avg_heart_rate_unit"
      assert session.total_descent == 120.5
      assert session.avg_power == 120.5
      assert session.pool_length == 120.5
    end

    test "create_session/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sessions.create_session(@invalid_attrs)
    end

    test "update_session/2 with valid data updates the session" do
      session = session_fixture()

      update_attrs = %{
        pool_length: 456.7,
        avg_power: 456.7,
        total_descent: 456.7,
        avg_heart_rate_unit: "some updated avg_heart_rate_unit",
        total_elapsed_time: 456.7,
        stroke_count: 456.7,
        total_distance: 456.7,
        avg_stroke_distance_unit: "some updated avg_stroke_distance_unit",
        avg_heart_rate: 456.7,
        avg_stroke_count_unit: "some updated avg_stroke_count_unit",
        max_heart_rate_unit: "some updated max_heart_rate_unit",
        total_elapsed_time_unit: "some updated total_elapsed_time_unit",
        max_heart_rate: 456.7,
        max_speed_unit: "some updated max_speed_unit",
        avg_stroke_count: 456.7,
        total_timer_time_unit: "some updated total_timer_time_unit",
        min_heart_rate_unit: "some updated min_heart_rate_unit",
        max_power: 456.7,
        total_timer_time: 456.7,
        total_descent_unit: "some updated total_descent_unit",
        avg_speed: 456.7,
        total_ascent: 456.7,
        avg_power_unit: "some updated avg_power_unit",
        pool_length_unit: "some updated pool_length_unit",
        sub_sport: "some updated sub_sport",
        total_ascent_unit: "some updated total_ascent_unit",
        total_moving_time: 456.7,
        timestamp: ~N[2023-05-04 15:44:00],
        total_moving_time_unit: "some updated total_moving_time_unit",
        max_power_unit: "some updated max_power_unit",
        avg_speed_unit: "some updated avg_speed_unit",
        max_speed: 456.7,
        sport: "some updated sport",
        stroke_count_unit: "some updated stroke_count_unit",
        total_distance_unit: "some updated total_distance_unit",
        threshold_power_unit: "some updated threshold_power_unit",
        avg_stroke_distance: 456.7,
        threshold_power: 456.7,
        min_heart_rate: 456.7
      }

      assert {:ok, %Session{} = session} = Sessions.update_session(session, update_attrs)
      assert session.min_heart_rate == 456.7
      assert session.threshold_power == 456.7
      assert session.avg_stroke_distance == 456.7
      assert session.threshold_power_unit == "some updated threshold_power_unit"
      assert session.total_distance_unit == "some updated total_distance_unit"
      assert session.stroke_count_unit == "some updated stroke_count_unit"
      assert session.sport == "some updated sport"
      assert session.max_speed == 456.7
      assert session.avg_speed_unit == "some updated avg_speed_unit"
      assert session.max_power_unit == "some updated max_power_unit"
      assert session.total_moving_time_unit == "some updated total_moving_time_unit"
      assert session.timestamp == ~N[2023-05-04 15:44:00]
      assert session.total_moving_time == 456.7
      assert session.total_ascent_unit == "some updated total_ascent_unit"
      assert session.sub_sport == "some updated sub_sport"
      assert session.pool_length_unit == "some updated pool_length_unit"
      assert session.avg_power_unit == "some updated avg_power_unit"
      assert session.total_ascent == 456.7
      assert session.avg_speed == 456.7
      assert session.total_descent_unit == "some updated total_descent_unit"
      assert session.total_timer_time == 456.7
      assert session.max_power == 456.7
      assert session.min_heart_rate_unit == "some updated min_heart_rate_unit"
      assert session.total_timer_time_unit == "some updated total_timer_time_unit"
      assert session.avg_stroke_count == 456.7
      assert session.max_speed_unit == "some updated max_speed_unit"
      assert session.max_heart_rate == 456.7
      assert session.total_elapsed_time_unit == "some updated total_elapsed_time_unit"
      assert session.max_heart_rate_unit == "some updated max_heart_rate_unit"
      assert session.avg_stroke_count_unit == "some updated avg_stroke_count_unit"
      assert session.avg_heart_rate == 456.7
      assert session.avg_stroke_distance_unit == "some updated avg_stroke_distance_unit"
      assert session.total_distance == 456.7
      assert session.stroke_count == 456.7
      assert session.total_elapsed_time == 456.7
      assert session.avg_heart_rate_unit == "some updated avg_heart_rate_unit"
      assert session.total_descent == 456.7
      assert session.avg_power == 456.7
      assert session.pool_length == 456.7
    end

    test "update_session/2 with invalid data returns error changeset" do
      session = session_fixture()
      assert {:error, %Ecto.Changeset{}} = Sessions.update_session(session, @invalid_attrs)
      assert session == Sessions.get_session!(session.id)
    end

    test "delete_session/1 deletes the session" do
      session = session_fixture()
      assert {:ok, %Session{}} = Sessions.delete_session(session)
      assert_raise Ecto.NoResultsError, fn -> Sessions.get_session!(session.id) end
    end

    test "change_session/1 returns a session changeset" do
      session = session_fixture()
      assert %Ecto.Changeset{} = Sessions.change_session(session)
    end
  end

  describe "training_loads" do
    alias PainCaveEx.Sessions.TrainingLoad

    import PainCaveEx.SessionsFixtures

    @invalid_attrs %{load: nil, type: nil}

    test "list_training_loads/0 returns all training_loads" do
      training_load = training_load_fixture()
      assert Sessions.list_training_loads() == [training_load]
    end

    test "get_training_load!/1 returns the training_load with given id" do
      training_load = training_load_fixture()
      assert Sessions.get_training_load!(training_load.id) == training_load
    end

    test "create_training_load/1 with valid data creates a training_load" do
      valid_attrs = %{load: 120.5, type: "some type"}

      assert {:ok, %TrainingLoad{} = training_load} = Sessions.create_training_load(valid_attrs)
      assert training_load.load == 120.5
      assert training_load.type == "some type"
    end

    test "create_training_load/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sessions.create_training_load(@invalid_attrs)
    end

    test "update_training_load/2 with valid data updates the training_load" do
      training_load = training_load_fixture()
      update_attrs = %{load: 456.7, type: "some updated type"}

      assert {:ok, %TrainingLoad{} = training_load} =
               Sessions.update_training_load(training_load, update_attrs)

      assert training_load.load == 456.7
      assert training_load.type == "some updated type"
    end

    test "update_training_load/2 with invalid data returns error changeset" do
      training_load = training_load_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Sessions.update_training_load(training_load, @invalid_attrs)

      assert training_load == Sessions.get_training_load!(training_load.id)
    end

    test "delete_training_load/1 deletes the training_load" do
      training_load = training_load_fixture()
      assert {:ok, %TrainingLoad{}} = Sessions.delete_training_load(training_load)
      assert_raise Ecto.NoResultsError, fn -> Sessions.get_training_load!(training_load.id) end
    end

    test "change_training_load/1 returns a training_load changeset" do
      training_load = training_load_fixture()
      assert %Ecto.Changeset{} = Sessions.change_training_load(training_load)
    end
  end
end
