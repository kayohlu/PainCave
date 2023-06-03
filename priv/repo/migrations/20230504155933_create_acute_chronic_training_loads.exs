defmodule PainCaveEx.Repo.Migrations.CreateAcuteChronicTrainingLoads do
  use Ecto.Migration

  def change do
    create table(:acute_chronic_training_loads, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :ratio, :float
      add :acute_load, :float
      add :chronic_load, :float
      add :acute_range, :integer
      add :chronic_range, :integer
      add :session_id, references(:sessions, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:acute_chronic_training_loads, [:session_id])
  end
end
