defmodule Nobinalo.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images, primary_key: false) do
      add :id, :binary_id,
        primary_key: true,
        default: fragment("uuid_generate_v1mc()")

      add :name, :string
      add :width, :integer
      add :height, :integer
      add :size, :integer
      add :mime, :string
      add :varient, :string
      add :profile_id, references(:profiles, on_delete: :nothing)

      timestamps()
    end

    create index(:images, [:profile_id])
  end
end
