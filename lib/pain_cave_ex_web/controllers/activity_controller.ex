defmodule PainCaveExWeb.ActivityController do
  use PainCaveExWeb, :controller

  alias PainCaveEx.Activities
  alias PainCaveEx.Activities.Activity

  def index(conn, params) do
    athlete =
      PainCaveEx.Athletes.list_athletes()
      |> List.first()

    activities = Activities.list_activities(athlete.id, params["sport"] || "swimming")

    render(conn, :index, activities: activities, sport: params["sport"] || "swimming")
  end

  def show(conn, %{"id" => id}) do
    activity = Activities.get_activity!(id)
    render(conn, :show, activity: activity)
  end
end
