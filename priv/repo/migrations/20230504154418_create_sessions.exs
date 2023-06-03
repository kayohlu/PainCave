defmodule PainCaveEx.Repo.Migrations.CreateSessions do
  use Ecto.Migration

  def change do
    create table(:sessions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :timestamp, :naive_datetime
      add :sport, :string
      add :sub_sport, :string
      add :total_elapsed_time, :float
      add :total_elapsed_time_unit, :string
      add :total_distance, :float
      add :total_distance_unit, :string
      add :total_timer_time, :float
      add :total_timer_time_unit, :string
      add :total_moving_time, :float
      add :total_moving_time_unit, :string
      add :total_calories, :float
      add :total_calories_unit, :string
      add :training_stress_score, :float
      add :training_stress_score_unit, :string
      add :intensity_factor, :float
      add :intensity_factor_unit, :string
      add :avg_speed, :float
      add :avg_speed_unit, :string
      add :max_speed, :float
      add :max_speed_unit, :string
      add :min_heart_rate, :float
      add :min_heart_rate_unit, :string
      add :avg_heart_rate, :float
      add :avg_heart_rate_unit, :string
      add :max_heart_rate, :float
      add :max_heart_rate_unit, :string
      add :avg_power, :float
      add :avg_power_unit, :string
      add :max_power, :float
      add :max_power_unit, :string
      add :threshold_power, :float
      add :threshold_power_unit, :string
      add :total_ascent, :float
      add :total_ascent_unit, :string
      add :total_descent, :float
      add :total_descent_unit, :string
      add :pool_length, :float
      add :pool_length_unit, :string
      add :stroke_count, :float
      add :stroke_count_unit, :string
      add :avg_stroke_count, :float
      add :avg_stroke_count_unit, :string
      add :avg_stroke_distance, :float
      add :avg_stroke_distance_unit, :string
      add :activity_id, references(:activities, on_delete: :nothing, type: :binary_id)
      add :athlete_id, references(:athletes, on_delete: :nothing, type: :binary_id)
      add :start_time, :naive_datetime
      add :end_time, :naive_datetime

      timestamps()
    end

    create index(:sessions, [:activity_id])
    create index(:sessions, [:athlete_id])
  end
end
