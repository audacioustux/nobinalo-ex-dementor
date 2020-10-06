defmodule Nobinalo.Repo.Migrations.CreateProfiles do
  use Ecto.Migration

  def change do
    create table(:profiles) do
      add(:display_name, :string, null: false)
      add(:gender, GenderEnum.type())
      add(:dob, :utc_datetime)
      add(:about, :string)
      add(:preferences, :map, default: "{}", null: false)

      add(
        :account_id,
        references(:accounts, type: :uuid, on_delete: :delete_all),
        null: false
      )

      timestamps()
    end

    create(index(:profiles, [:account_id]))
  end
end
