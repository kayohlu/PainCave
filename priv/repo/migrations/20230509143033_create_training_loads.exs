defmodule PainCaveEx.Repo.Migrations.CreateTrainingLoads do
  use Ecto.Migration

  def change do
    create table(:training_loads, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :load, :float
      add :type, :string
      add :session_id, references(:sessions, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:training_loads, [:session_id])
  end
end
