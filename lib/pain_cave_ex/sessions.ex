defmodule PainCaveEx.Sessions do
  @moduledoc """
  The Sessions context.
  """

  import Ecto.Query, warn: false
  alias PainCaveEx.Repo

  alias PainCaveEx.Sessions.Session

  @doc """
  Returns the list of sessions.

  ## Examples

      iex> list_sessions()
      [%Session{}, ...]

  """
  def list_sessions(athlete_id) do
    Repo.all(
      from a in Session,
        where: a.athlete_id == ^athlete_id,
        order_by: [desc: :timestamp]
    )
  end

  @doc """
  Gets a single session.

  Raises `Ecto.NoResultsError` if the Session does not exist.

  ## Examples

      iex> get_session!(123)
      %Session{}

      iex> get_session!(456)
      ** (Ecto.NoResultsError)

  """
  def get_session!(id), do: Repo.get!(Session, id)

  @doc """
  Creates a session.

  ## Examples

      iex> create_session(%{field: value})
      {:ok, %Session{}}

      iex> create_session(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_session(attrs \\ %{}) do
    %Session{}
    |> Session.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a session.

  ## Examples

      iex> update_session(session, %{field: new_value})
      {:ok, %Session{}}

      iex> update_session(session, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_session(%Session{} = session, attrs) do
    session
    |> Session.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a session.

  ## Examples

      iex> delete_session(session)
      {:ok, %Session{}}

      iex> delete_session(session)
      {:error, %Ecto.Changeset{}}

  """
  def delete_session(%Session{} = session) do
    Repo.delete(session)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking session changes.

  ## Examples

      iex> change_session(session)
      %Ecto.Changeset{data: %Session{}}

  """
  def change_session(%Session{} = session, attrs \\ %{}) do
    Session.changeset(session, attrs)
  end

  alias PainCaveEx.Sessions.TrainingLoad

  @doc """
  Returns the list of training_loads.

  ## Examples

      iex> list_training_loads()
      [%TrainingLoad{}, ...]

  """
  def list_training_loads do
    Repo.all(TrainingLoad)
  end

  @doc """
  Gets a single training_load.

  Raises `Ecto.NoResultsError` if the Training load does not exist.

  ## Examples

      iex> get_training_load!(123)
      %TrainingLoad{}

      iex> get_training_load!(456)
      ** (Ecto.NoResultsError)

  """
  def get_training_load!(id), do: Repo.get!(TrainingLoad, id)

  @doc """
  Creates a training_load.

  ## Examples

      iex> create_training_load(%{field: value})
      {:ok, %TrainingLoad{}}

      iex> create_training_load(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_training_load(attrs \\ %{}) do
    %TrainingLoad{}
    |> TrainingLoad.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a training_load.

  ## Examples

      iex> update_training_load(training_load, %{field: new_value})
      {:ok, %TrainingLoad{}}

      iex> update_training_load(training_load, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_training_load(%TrainingLoad{} = training_load, attrs) do
    training_load
    |> TrainingLoad.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a training_load.

  ## Examples

      iex> delete_training_load(training_load)
      {:ok, %TrainingLoad{}}

      iex> delete_training_load(training_load)
      {:error, %Ecto.Changeset{}}

  """
  def delete_training_load(%TrainingLoad{} = training_load) do
    Repo.delete(training_load)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking training_load changes.

  ## Examples

      iex> change_training_load(training_load)
      %Ecto.Changeset{data: %TrainingLoad{}}

  """
  def change_training_load(%TrainingLoad{} = training_load, attrs \\ %{}) do
    TrainingLoad.changeset(training_load, attrs)
  end

  def calculate_training_stress_balance(%Session{} = session) do
    Float.round(
      session.acute_chronic_training_load.chronic_load -
        session.acute_chronic_training_load.acute_load,
      2
    )
  end

  def calculate_atl(%Session{} = session) do
    {:ok, timestamp} = DateTime.from_naive(session.timestamp, "Etc/UTC")
    datetime = DateTime.add(timestamp, -7, :day)
    sport = session.sport

    query =
      from(
        tl in TrainingLoad,
        join: s in Session,
        on: s.id == tl.session_id,
        where: s.athlete_id == ^session.athlete_id,
        where: s.timestamp >= ^datetime,
        where: s.sport == ^sport,
        select: tl.load
      )

    Repo.aggregate(query, :sum, :load)
  end

  def calculate_ctl(%Session{} = session) do
    {:ok, timestamp} = DateTime.from_naive(session.timestamp, "Etc/UTC")
    datetime = DateTime.add(timestamp, -42, :day)
    sport = session.sport

    query =
      from(
        tl in TrainingLoad,
        join: s in Session,
        on: s.id == tl.session_id,
        where: s.athlete_id == ^session.athlete_id,
        where: s.timestamp >= ^datetime,
        where: s.sport == ^sport,
        select: tl.load
      )

    Repo.aggregate(query, :avg, :load)
  end
end
