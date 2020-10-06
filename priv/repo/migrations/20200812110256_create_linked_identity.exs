defmodule Nobinalo.Repo.Migrations.CreateLinkedIdentity do
  use Ecto.Migration

  def change do
    create table(:linked_identities, primary_key: false) do
      add :provider, LinkedIdentityProviderEnum.type(), null: false
      add :uid, :string, null: false
      add :access_token, :string, null: false

      add :account_id,
          references(:accounts, type: :uuid, on_delete: :nothing),
          null: false

      add(:raw_response, :map, default: "{}", null: false)

      timestamps()
    end

    create index(:linked_identities, [:provider, :uid],
             unique: true,
             primary_key: true
           )

    create index(:linked_identities, [:account_id])
  end
end
