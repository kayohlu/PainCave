defmodule PainCaveEx.Repo do
  use Ecto.Repo,
    otp_app: :pain_cave_ex,
    adapter: Ecto.Adapters.Postgres
end
