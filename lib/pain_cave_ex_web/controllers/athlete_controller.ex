defmodule PainCaveExWeb.AthleteController do
  use PainCaveExWeb, :controller

  alias PainCaveEx.Athletes
  alias PainCaveEx.Athletes.Athlete

  def index(conn, _params) do
    athletes = Athletes.list_athletes()
    render(conn, :index, athletes: athletes)
  end

  def show(conn, %{"id" => id}) do
    athlete = Athletes.get_athlete!(id)
    render(conn, :show, athlete: athlete)
  end

  def delete(conn, %{"id" => id}) do
    athlete = Athletes.get_athlete!(id)
    {:ok, _athlete} = Athletes.delete_athlete(athlete)

    conn
    |> put_flash(:info, "Athlete deleted successfully.")
    |> redirect(to: ~p"/athletes")
  end
end
