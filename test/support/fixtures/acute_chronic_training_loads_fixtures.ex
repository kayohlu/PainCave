defmodule PainCaveEx.AcuteChronicTrainingLoadsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PainCaveEx.AcuteChronicTrainingLoads` context.
  """

  @doc """
  Generate a acute_chronic_training_load.
  """
  def acute_chronic_training_load_fixture(attrs \\ %{}) do
    {:ok, acute_chronic_training_load} =
      attrs
      |> Enum.into(%{
        acute_load: 120.5,
        acute_range: 42,
        chronic_load: 120.5,
        chronic_range: 42,
        ratio: 120.5
      })
      |> PainCaveEx.AcuteChronicTrainingLoads.create_acute_chronic_training_load()

    acute_chronic_training_load
  end
end
