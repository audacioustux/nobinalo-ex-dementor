defmodule Nobinalo.Repo.Migrations.Init do
  use Ecto.Migration

  def change do
    execute(
      ~S[CREATE EXTENSION IF NOT EXISTS "uuid-ossp"],
      ~S[DROP EXTENSION IF EXISTS "uuid-ossp"]
    )

    execute(
      ~S[CREATE EXTENSION IF NOT EXISTS "citext"],
      ~S[DROP EXTENSION IF EXISTS "citext"]
    )
  end
end
