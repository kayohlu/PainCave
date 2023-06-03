defmodule PainCaveEx.Repo.Migrations.CreateActivities do
  use Ecto.Migration

  def change do
    create table(:activities, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :total_distance, :float
      add :total_distance_unit, :string
      add :total_timer_time, :float
      add :total_timer_time_unit, :string
      add :timestamp, :naive_datetime
      add :athlete_id, references(:athletes, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:activities, [:athlete_id])
  end
end
