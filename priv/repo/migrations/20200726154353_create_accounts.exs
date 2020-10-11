defmodule Nobinalo.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add(:id, :binary_id,
        primary_key: true,
        default: fragment("uuid_generate_v1mc()")
      )

      add(:handle, :string, size: 24, null: false)
      # emojis takes up more than one codepoints,
      # should be validated to be exactly 4 graphene long
      add(:ntag, :string, size: 32, null: false)
      add(:password_hash, :string)
      add(:state, AccountStateEnum.type(), null: false, default: 0)

      add(
        :successor_id,
        references(:accounts, on_delete: :nilify_all, type: :binary_id)
      )

      add(
        :supervisor_id,
        references(:accounts, on_delete: :restrict, type: :binary_id)
      )

      timestamps()
    end

    create(index(:accounts, [:successor_id]))
    create(index(:accounts, [:supervisor_id]))
    unique_index(:accounts, [:handle, :ntag])
  end
end
