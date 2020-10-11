defmodule Nobinalo.Emails.Email do
  @moduledoc false

  use Nobinalo.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}

  alias Ecto.UUID

  alias Nobinalo.Accounts.Account

  # https://html.spec.whatwg.org/multipage/input.html#e-mail-state-(type=email)
  # because fuck rfc5322 -_-
  @email_re ~r/^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/

  @primary_key {:id, :binary_id, read_after_writes: true}
  schema "emails" do
    field :email, :string
    field :is_backup, :boolean, default: false
    field :is_primary, :boolean, default: false
    field :is_public, :boolean, default: false
    field :verified_at, :utc_datetime_usec
    field :is_verified, :boolean, virtual: true, default: false

    belongs_to(:account, Account, type: UUID)

    timestamps()
  end

  @required_fields ~w[email account_id]a
  @optional_fields ~w[is_verified]a

  @spec create_changeset(t, map) :: Changeset.t()
  def create_changeset(email, attrs) do
    email
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:account_id)
    |> validate_email()
  end

  @spec validate_email(Changeset.t()) :: Changeset.t()
  defp validate_email(changeset) do
    changeset
    |> validate_length(:email, min: 3, max: 255)
    |> validate_format(:email, @email_re)
  end

  @spec set_verified_changeset(t) :: Changeset.t()
  def set_verified_changeset(email),
    do: change(email, verified_at: DateTime.utc_now())
end
