defmodule PainCaveEx.SessionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PainCaveEx.Sessions` context.
  """

  @doc """
  Generate a session.
  """
  def session_fixture(attrs \\ %{}) do
    {:ok, session} =
      attrs
      |> Enum.into(%{
        min_heart_rate: 120.5,
        threshold_power: 120.5,
        avg_stroke_distance: 120.5,
        threshold_power_unit: "some threshold_power_unit",
        total_distance_unit: "some total_distance_unit",
        stroke_count_unit: "some stroke_count_unit",
        sport: "some sport",
        max_speed: 120.5,
        avg_speed_unit: "some avg_speed_unit",
        max_power_unit: "some max_power_unit",
        total_moving_time_unit: "some total_moving_time_unit",
        timestamp: ~N[2023-05-03 15:44:00],
        total_moving_time: 120.5,
        total_ascent_unit: "some total_ascent_unit",
        sub_sport: "some sub_sport",
        pool_length_unit: "some pool_length_unit",
        avg_power_unit: "some avg_power_unit",
        total_ascent: 120.5,
        avg_speed: 120.5,
        total_descent_unit: "some total_descent_unit",
        total_timer_time: 120.5,
        max_power: 120.5,
        min_heart_rate_unit: "some min_heart_rate_unit",
        total_timer_time_unit: "some total_timer_time_unit",
        avg_stroke_count: 120.5,
        max_speed_unit: "some max_speed_unit",
        max_heart_rate: 120.5,
        total_elapsed_time_unit: "some total_elapsed_time_unit",
        max_heart_rate_unit: "some max_heart_rate_unit",
        avg_stroke_count_unit: "some avg_stroke_count_unit",
        avg_heart_rate: 120.5,
        avg_stroke_distance_unit: "some avg_stroke_distance_unit",
        total_distance: 120.5,
        stroke_count: 120.5,
        total_elapsed_time: 120.5,
        avg_heart_rate_unit: "some avg_heart_rate_unit",
        total_descent: 120.5,
        avg_power: 120.5,
        pool_length: 120.5
      })
      |> PainCaveEx.Sessions.create_session()

    session
  end

  @doc """
  Generate a training_load.
  """
  def training_load_fixture(attrs \\ %{}) do
    {:ok, training_load} =
      attrs
      |> Enum.into(%{
        load: 120.5,
        type: "some type"
      })
      |> PainCaveEx.Sessions.create_training_load()

    training_load
  end
end
