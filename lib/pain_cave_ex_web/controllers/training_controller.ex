defmodule PainCaveExWeb.TrainingController do
  use PainCaveExWeb, :controller

  alias PainCaveEx.Trainings

  def show(conn, _params) do
    render(conn, :show)
  end
end
