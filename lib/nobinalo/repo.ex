defmodule Nobinalo.Repo do
  use Ecto.Repo,
    otp_app: :nobinalo,
    adapter: Ecto.Adapters.Postgres
end
