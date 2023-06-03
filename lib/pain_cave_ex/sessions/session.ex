defmodule PainCaveEx.Sessions.Session do
  use Ecto.Schema
  import Ecto.Changeset

  alias PainCaveEx.Activities.Activity
  alias PainCaveEx.Athletes.Athlete
  alias PainCaveEx.Sessions.TrainingLoad
  alias PainCaveEx.AcuteChronicTrainingLoads.AcuteChronicTrainingLoad

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "sessions" do
    field :min_heart_rate, :float
    field :threshold_power, :float
    field :avg_stroke_distance, :float
    field :threshold_power_unit, :string
    field :total_distance_unit, :string
    field :stroke_count_unit, :string
    field :sport, :string
    field :max_speed, :float
    field :avg_speed_unit, :string
    field :max_power_unit, :string
    field :total_moving_time_unit, :string
    field :total_calories, :float
    field :total_calories_unit, :string
    field :training_stress_score, :float
    field :training_stress_score_unit, :string
    field :intensity_factor, :float
    field :intensity_factor_unit, :string
    field :timestamp, :naive_datetime
    field :total_moving_time, :float
    field :total_ascent_unit, :string
    field :sub_sport, :string
    field :pool_length_unit, :string
    field :avg_power_unit, :string
    field :total_ascent, :float
    field :avg_speed, :float
    field :total_descent_unit, :string
    field :total_timer_time, :float
    field :max_power, :float
    field :min_heart_rate_unit, :string
    field :total_timer_time_unit, :string
    field :avg_stroke_count, :float
    field :max_speed_unit, :string
    field :max_heart_rate, :float
    field :total_elapsed_time_unit, :string
    field :max_heart_rate_unit, :string
    field :avg_stroke_count_unit, :string
    field :avg_heart_rate, :float
    field :avg_stroke_distance_unit, :string
    field :total_distance, :float
    field :stroke_count, :float
    field :total_elapsed_time, :float
    field :avg_heart_rate_unit, :string
    field :total_descent, :float
    field :avg_power, :float
    field :pool_length, :float
    field :start_time, :naive_datetime
    field :end_time, :naive_datetime

    belongs_to :activity, Activity
    belongs_to :athlete, Athlete
    has_one :training_load, TrainingLoad
    has_one :acute_chronic_training_load, AcuteChronicTrainingLoad

    timestamps()
  end

  @doc false
  def changeset(session, attrs) do
    session
    |> cast(attrs, [
      :sport,
      :sub_sport,
      :total_elapsed_time,
      :total_elapsed_time_unit,
      :total_distance,
      :total_distance_unit,
      :total_timer_time,
      :total_timer_time_unit,
      :total_elapsed_time,
      :total_elapsed_time_unit,
      :total_moving_time,
      :total_moving_time_unit,
      :avg_speed,
      :avg_speed_unit,
      :max_speed,
      :max_speed_unit,
      :min_heart_rate,
      :min_heart_rate_unit,
      :avg_heart_rate,
      :avg_heart_rate_unit,
      :max_heart_rate,
      :max_heart_rate_unit,
      :avg_power,
      :avg_power_unit,
      :max_power,
      :max_power_unit,
      :threshold_power,
      :threshold_power_unit,
      :total_ascent,
      :total_ascent_unit,
      :total_descent,
      :total_descent_unit,
      :pool_length,
      :pool_length_unit,
      :stroke_count,
      :stroke_count_unit,
      :avg_stroke_count,
      :avg_stroke_count_unit,
      :avg_stroke_distance,
      :avg_stroke_distance_unit,
      :timestamp,
      :activity_id,
      :athlete_id,
      :start_time,
      :end_time,
      :total_calories,
      :total_calories_unit,
      :training_stress_score,
      :training_stress_score_unit,
      :intensity_factor,
      :intensity_factor_unit
    ])
    |> validate_required([
      :activity_id,
      :athlete_id,
      :timestamp,
      :sport,
      :sub_sport,
      :timestamp,
      :start_time,
      :end_time
    ])
  end
end
