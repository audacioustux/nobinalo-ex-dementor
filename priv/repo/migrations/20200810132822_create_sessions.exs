defmodule Nobinalo.Repo.Migrations.CreateSessions do
  use Ecto.Migration

  def change do
    create table(:sessions) do
      timestamps()
    end
  end
end
