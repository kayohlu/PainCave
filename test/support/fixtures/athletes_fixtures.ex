defmodule PainCaveEx.AthletesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PainCaveEx.Athletes` context.
  """

  @doc """
  Generate a athlete.
  """
  def athlete_fixture(attrs \\ %{}) do
    {:ok, athlete} =
      attrs
      |> Enum.into(%{
        email: "some email",
        name: "some name"
      })
      |> PainCaveEx.Athletes.create_athlete()

    athlete
  end
end
