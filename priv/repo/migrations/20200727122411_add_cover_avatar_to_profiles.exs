defmodule Nobinalo.Repo.Migrations.AddCoverAvatarToProfiles do
  use Ecto.Migration

  def change do
    alter table(:profiles) do
      add :avatar_id, references(:images, type: :binary_id)
      add :cover_id, references(:images, type: :binary_id)
    end

    create index(:profiles, [:avatar_id])
    create index(:profiles, [:cover_id])
  end
end
