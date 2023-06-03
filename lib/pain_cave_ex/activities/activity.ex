defmodule PainCaveEx.Activities.Activity do
  use Ecto.Schema
  import Ecto.Changeset

  alias PainCaveEx.Athletes.Athlete
  alias PainCaveEx.Sessions.Session

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "activities" do
    field :name, :string
    field :timestamp, :naive_datetime
    field :total_distance, :float
    field :total_distance_unit, :string
    field :total_timer_time, :float
    field :total_timer_time_unit, :string

    belongs_to :athlete, Athlete
    has_many :sessions, Session

    timestamps()
  end

  @doc false
  def changeset(activity, attrs) do
    activity
    |> cast(attrs, [
      :name,
      :total_distance,
      :total_distance_unit,
      :total_timer_time,
      :total_timer_time_unit,
      :timestamp,
      :athlete_id
    ])
    |> validate_required([
      :name,
      :total_distance,
      :total_distance_unit,
      :total_timer_time,
      :total_timer_time_unit,
      :timestamp,
      :athlete_id
    ])
  end
end
