defmodule PainCaveEx.TrainingsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PainCaveEx.Trainings` context.
  """

  @doc """
  Generate a training.
  """
  def training_fixture(attrs \\ %{}) do
    {:ok, training} =
      attrs
      |> Enum.into(%{
        test: "some test"
      })
      |> PainCaveEx.Trainings.create_training()

    training
  end
end
