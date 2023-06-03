defmodule PainCaveEx.Sessions.TrainingLoad do
  use Ecto.Schema
  import Ecto.Changeset

  alias PainCaveEx.Sessions.Session

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "training_loads" do
    field :load, :float
    field :type, :string

    belongs_to :session, Session

    timestamps()
  end

  @doc false
  def changeset(training_load, attrs) do
    training_load
    |> cast(attrs, [:load, :type, :session_id])
    |> validate_required([:load, :type])
  end
end
