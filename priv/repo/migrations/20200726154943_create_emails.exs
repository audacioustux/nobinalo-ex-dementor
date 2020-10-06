defmodule Nobinalo.Repo.Migrations.CreateEmails do
  use Ecto.Migration

  def change do
    create table(:emails, primary_key: false) do
      add :id, :binary_id,
        primary_key: true,
        default: fragment("uuid_generate_v1mc()")

      add :email, :citext, null: false
      add :is_primary, :boolean, default: false, null: false
      add :is_public, :boolean, default: false, null: false
      add :is_backup, :boolean, default: false, null: false
      add :verified_at, :timestamptz

      add :account_id,
          references(:accounts, type: :uuid, on_delete: :nothing),
          null: false

      timestamps()
    end

    # verified emails must be unique
    create unique_index(:emails, :email,
             where: "verified_at IS NOT NULL",
             name: "emails_verified_unique_index"
           )

    # disallow multiple unverified per account
    create unique_index(:emails, :account_id,
             where: "verified_at IS NULL",
             name: "emails_unverified_unique_account_index"
           )

    # foreign key index
    create index(:emails, :account_id)

    # only allow one primary email
    create unique_index(:emails, :account_id,
             where: "is_primary AND verified_at IS NOT NULL",
             name: "emails_primary_unique_index"
           )
  end
end
