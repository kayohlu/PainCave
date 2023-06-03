defmodule PainCaveEx.AcuteChronicTrainingLoads.AcuteChronicTrainingLoad do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "acute_chronic_training_loads" do
    field :acute_load, :float
    field :acute_range, :integer
    field :chronic_load, :float
    field :chronic_range, :integer
    field :ratio, :float

    belongs_to :session, Session

    timestamps()
  end

  @doc false
  def changeset(acute_chronic_training_load, attrs) do
    acute_chronic_training_load
    |> cast(attrs, [:ratio, :acute_load, :chronic_load, :acute_range, :chronic_range, :session_id])
    |> validate_required([:ratio, :acute_load, :chronic_load, :acute_range, :chronic_range])
  end
end
