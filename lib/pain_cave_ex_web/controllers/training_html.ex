defmodule PainCaveExWeb.TrainingHTML do
  use PainCaveExWeb, :html

  embed_templates "training_html/*"

  @doc """
  Renders a training form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def training_form(assigns)
end
