defmodule PainCaveEx.AcuteChronicTrainingLoads do
  @moduledoc """
  The AcuteChronicTrainingLoads context.
  """

  import Ecto.Query, warn: false
  alias PainCaveEx.Repo

  alias PainCaveEx.AcuteChronicTrainingLoads.AcuteChronicTrainingLoad

  @doc """
  Returns the list of acute_chronic_training_loads.

  ## Examples

      iex> list_acute_chronic_training_loads()
      [%AcuteChronicTrainingLoad{}, ...]

  """
  def list_acute_chronic_training_loads do
    Repo.all(AcuteChronicTrainingLoad)
  end

  @doc """
  Gets a single acute_chronic_training_load.

  Raises `Ecto.NoResultsError` if the Acute chronic training load does not exist.

  ## Examples

      iex> get_acute_chronic_training_load!(123)
      %AcuteChronicTrainingLoad{}

      iex> get_acute_chronic_training_load!(456)
      ** (Ecto.NoResultsError)

  """
  def get_acute_chronic_training_load!(id), do: Repo.get!(AcuteChronicTrainingLoad, id)

  @doc """
  Creates a acute_chronic_training_load.

  ## Examples

      iex> create_acute_chronic_training_load(%{field: value})
      {:ok, %AcuteChronicTrainingLoad{}}

      iex> create_acute_chronic_training_load(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_acute_chronic_training_load(attrs \\ %{}) do
    %AcuteChronicTrainingLoad{}
    |> AcuteChronicTrainingLoad.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a acute_chronic_training_load.

  ## Examples

      iex> update_acute_chronic_training_load(acute_chronic_training_load, %{field: new_value})
      {:ok, %AcuteChronicTrainingLoad{}}

      iex> update_acute_chronic_training_load(acute_chronic_training_load, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_acute_chronic_training_load(
        %AcuteChronicTrainingLoad{} = acute_chronic_training_load,
        attrs
      ) do
    acute_chronic_training_load
    |> AcuteChronicTrainingLoad.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a acute_chronic_training_load.

  ## Examples

      iex> delete_acute_chronic_training_load(acute_chronic_training_load)
      {:ok, %AcuteChronicTrainingLoad{}}

      iex> delete_acute_chronic_training_load(acute_chronic_training_load)
      {:error, %Ecto.Changeset{}}

  """
  def delete_acute_chronic_training_load(
        %AcuteChronicTrainingLoad{} = acute_chronic_training_load
      ) do
    Repo.delete(acute_chronic_training_load)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking acute_chronic_training_load changes.

  ## Examples

      iex> change_acute_chronic_training_load(acute_chronic_training_load)
      %Ecto.Changeset{data: %AcuteChronicTrainingLoad{}}

  """
  def change_acute_chronic_training_load(
        %AcuteChronicTrainingLoad{} = acute_chronic_training_load,
        attrs \\ %{}
      ) do
    AcuteChronicTrainingLoad.changeset(acute_chronic_training_load, attrs)
  end
end
