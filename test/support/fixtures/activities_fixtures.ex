defmodule PainCaveEx.ActivitiesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PainCaveEx.Activities` context.
  """

  @doc """
  Generate a activity.
  """
  def activity_fixture(attrs \\ %{}) do
    {:ok, activity} =
      attrs
      |> Enum.into(%{
        name: "some name",
        timestamp: ~N[2023-05-03 15:31:00],
        total_distance: 120.5,
        total_distance_unit: "some total_distance_unit",
        total_timer_time: 120.5,
        total_timer_time_unit: "some total_timer_time_unit"
      })
      |> PainCaveEx.Activities.create_activity()

    activity
  end
end
