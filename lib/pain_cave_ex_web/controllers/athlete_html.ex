defmodule PainCaveExWeb.AthleteHTML do
  use PainCaveExWeb, :html

  embed_templates "athlete_html/*"

  @doc """
  Renders a athlete form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def athlete_form(assigns)
end
