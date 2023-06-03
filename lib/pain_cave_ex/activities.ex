defmodule PainCaveEx.Activities do
  @moduledoc """
  The Activities context.
  """

  import Ecto.Query, warn: false
  alias PainCaveEx.Repo

  alias PainCaveEx.Activities.Activity
  alias PainCaveEx.Sessions.Session
  alias PainCaveEx.AcuteChronicTrainingLoads.AcuteChronicTrainingLoad

  def sports do
    ["swimming", "cycling", "running", "transition"]
  end

  @doc """
  Returns the list of activities.

  ## Examples

      iex> list_activities()
      [%Activity{}, ...]

  """
  def list_activities(athlete_id, sport) do
    sessions_query =
      from s in Session,
        where: s.sport == ^sport,
        order_by: [desc: :timestamp],
        preload: [:acute_chronic_training_load, :training_load]

    Repo.all(
      from a in Activity,
        where: a.athlete_id == ^athlete_id,
        order_by: [desc: :timestamp],
        preload: [sessions: ^sessions_query]
    )
  end

  @doc """
  Gets a single activity.

  Raises `Ecto.NoResultsError` if the Activity does not exist.

  ## Examples

      iex> get_activity!(123)
      %Activity{}

      iex> get_activity!(456)
      ** (Ecto.NoResultsError)

  """
  def get_activity!(id), do: Repo.get!(Activity, id)

  @doc """
  Creates a activity.

  ## Examples

      iex> create_activity(%{field: value})
      {:ok, %Activity{}}

      iex> create_activity(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_activity(attrs \\ %{}) do
    IO.inspect(attrs)

    %Activity{}
    |> Activity.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a activity.

  ## Examples

      iex> update_activity(activity, %{field: new_value})
      {:ok, %Activity{}}

      iex> update_activity(activity, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_activity(%Activity{} = activity, attrs) do
    activity
    |> Activity.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a activity.

  ## Examples

      iex> delete_activity(activity)
      {:ok, %Activity{}}

      iex> delete_activity(activity)
      {:error, %Ecto.Changeset{}}

  """
  def delete_activity(%Activity{} = activity) do
    Repo.delete(activity)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking activity changes.

  ## Examples

      iex> change_activity(activity)
      %Ecto.Changeset{data: %Activity{}}

  """
  def change_activity(%Activity{} = activity, attrs \\ %{}) do
    Activity.changeset(activity, attrs)
  end
end
