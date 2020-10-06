defmodule Nobinalo.LinkedIdentities.LinkedIdentity do
  use Ecto.Schema
  import Ecto.Changeset

  alias Nobinalo.Accounts.Account

  @primary_key false
  schema "linked_identities" do
    field(:provider, LinkedIdentityProviderEnum, primary_key: true)
    field(:uid, :string, primary_key: true)

    field(:access_token, :string)
    field(:refresh_token, :string)
    field(:token_type, TokenTypeEnum, default: :bearer)

    field(:scopes, {:array, :string})
    field(:raw_response, :map)

    field(:expires_at, :utc_datetime_usec)

    belongs_to(:account, Account)

    timestamps()
  end

  @required_fields ~w[provider uid access_token scopes raw_response account_id]a
  @optional_fields ~w[refresh_token expires_at]a

  @doc """
  Create changeset for linked identities
  """
  def create_changeset(linked_identity, attrs) do
    linked_identity
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:account_id)
  end
end
