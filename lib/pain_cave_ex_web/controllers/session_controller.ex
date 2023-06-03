defmodule PainCaveExWeb.SessionController do
  use PainCaveExWeb, :controller

  alias PainCaveEx.Sessions
  alias PainCaveEx.Sessions.Session

  def index(conn, _params) do
    sessions = Sessions.list_sessions()
    render(conn, :index, sessions: sessions)
  end

  def show(conn, %{"id" => id}) do
    session = Sessions.get_session!(id)
    render(conn, :show, session: session)
  end

  def delete(conn, %{"id" => id}) do
    session = Sessions.get_session!(id)
    {:ok, _session} = Sessions.delete_session(session)

    conn
    |> put_flash(:info, "Session deleted successfully.")
    |> redirect(to: ~p"/sessions")
  end
end
