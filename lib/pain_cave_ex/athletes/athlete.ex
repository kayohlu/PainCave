defmodule PainCaveEx.Athletes.Athlete do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "athletes" do
    field :email, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(athlete, attrs) do
    athlete
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end
end
