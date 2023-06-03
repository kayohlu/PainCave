defmodule PainCaveEx.Trainings do
  @moduledoc """
  The Trainings context.
  """

  import Ecto.Query, warn: false
  alias PainCaveEx.Repo
  alias PainCaveEx.Sessions
  alias PainCaveEx.Activities
  alias PainCaveEx.Sessions.Session

  def training_summary(athlete) do
    Enum.reduce(Activities.sports, %{}, fn (sport, acc) ->
      atl = atl(athlete, sport)
      ctl = ctl(athlete, sport)

      tsb =
        Sessions.calculate_training_stress_balance(%Session{
          acute_chronic_training_load: %{
            chronic_load: ctl,
            acute_load: atl
          }
        })

      Map.put(acc, sport,
        %{
          acute_training_load: atl,
          chronic_training_load: ctl,
          training_stree_balance: tsb,
          acute_chronic_training_load_ratio: atl / ctl
        }
      )
    end)
  end

  def atl(athlete, sport) do
    Sessions.calculate_atl(latest_session(athlete, sport))
  end

  def ctl(athlete, sport) do
    Sessions.calculate_ctl(latest_session(athlete, sport))
  end

  def latest_session(athlete, sport) do
    %Session{timestamp: DateTime.utc_now(), sport: sport, athlete_id: athlete.id}
  end
end
