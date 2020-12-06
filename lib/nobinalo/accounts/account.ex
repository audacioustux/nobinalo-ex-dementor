defmodule Nobinalo.Accounts.Account do
  @moduledoc """
  Models a Account

  handle = (username + ntag), is unique per user
  where, ntag (nobinalo tag) is exactly 4 character or grapheme long
  that is, randomly or user specified tag
  as, multiple users can have the same nickname
  so, ntag is the discriminator in case of identical nickname
  """
  use Nobinalo.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}

  alias Nobinalo.{
    Repo,
    Emails.Email,
    Profiles.Profile,
    LinkedIdentities.LinkedIdentity
  }

  @primary_key {:id, :binary_id, read_after_writes: true}
  schema "accounts" do
    field(:nickname, :string)
    field(:ntag, :string)
    field(:state, AccountStateEnum, default: :active)
    field(:password, :string, virtual: true, redact: true)
    field(:password_hash, :string)

    belongs_to(:successor, __MODULE__, type: :binary_id)
    belongs_to(:supervisor, __MODULE__, type: :binary_id)

    has_many(:supervisor_of, __MODULE__, foreign_key: :supervisor_id)
    has_many(:successor_of, __MODULE__, foreign_key: :successor_id)

    has_one(:profile, Profile)
    has_many(:emails, Email)
    has_many(:linked_identities, LinkedIdentity)

    timestamps()
  end

  @password_len [min: 8, max: 80]
  @nickname_len [min: 3, max: 24]
  @nickname_format_validators [
    {~r/^(?![_.])/, ~S["." or "_" not allowed at the beginning]},
    {~r/(?!.*[_.]{2})/, ~S["__", "_.", "._", ".." are not allowed]},
    {~r/(?=.*[a-z])/, ~S[at-least one alphabet a-z must be used]},
    {~r/[a-z0-9._]+/, ~S[only a-z, 0-9 and ".", "_" are allowed]},
    {~r/(?<![_.])$/, ~S["." or "_" not allowed at the end]}
  ]
  @handle_fields ~w[:nickname :ntag]a
  # filter reserved_words list for valid handle
  # TODO: use bloom filter (maybe bloomex)
  @reserved_nicknames File.read!("priv/dictionaries/reserved_words.json")
                      |> Jason.decode!()
                      |> Enum.filter(fn nickname ->
                        Enum.any?(
                          @nickname_format_validators,
                          fn validator ->
                            {re, _} = validator
                            Regex.match?(re, nickname)
                          end
                        )
                      end)
                      |> MapSet.new()

  @required_fields ~w[nickname password]a
  @spec create_changeset(t, map) :: Changeset.t()
  def create_changeset(account, %{emails: _} = attrs) do
    account
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> cast_assoc(:profile, with: &Profile.create_changeset/2, required: true)
    |> cast_assoc(:emails, with: &Email.create_changeset/2, required: true)
    |> validate_handle()
    |> validate_password()
  end

  @required_fields ~w[nickname]a
  def create_changeset(account, %{linked_identities: _} = attrs) do
    account
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> cast_assoc(:profile, with: &Profile.create_changeset/2, required: true)
    |> cast_assoc(:linked_identities,
      with: &LinkedIdentity.create_changeset/2,
      required: true
    )
    |> validate_handle()
  end

  @ntag_many_err_msg ~S[too many users with this nickname! not available :(]
  @spec validate_handle(Changeset.t()) :: Changeset.t()
  defp validate_handle(changeset) do
    changeset
    |> validate_nickname()
    |> put_ntag()
    |> unsafe_validate_unique(@handle_fields, Repo, message: @ntag_many_err_msg)
    |> unique_constraint(@handle_fields, message: @ntag_many_err_msg)
  end

  @spec validate_nickname(Changeset.t()) :: Changeset.t()
  defp validate_nickname(changeset) do
    changeset
    |> validate_length(:nickname, @nickname_len)
    |> validate_nickname_format()
    |> validate_exclusion(:nickname, @reserved_nicknames)
  end

  # TODO: improve ntag generation
  @spec put_ntag(Changeset.t()) :: Changeset.t()
  defp put_ntag(changeset) do
    # generate 4 digit randomly generated number as ntag
    # 0000..0009 and 9991..9999 reserved for later use
    changeset
    |> put_change(
      :ntag,
      Enum.random(9..9990)
      |> Integer.to_string()
      |> String.pad_leading(4, ["0"])
    )
  end

  @spec validate_nickname_format(Changeset.t()) :: Changeset.t()
  defp validate_nickname_format(changeset) do
    List.foldl(
      @nickname_format_validators,
      changeset,
      fn validator, changeset_acc ->
        {re, message} = validator
        validate_format(changeset_acc, :handle, re, message)
      end
    )
  end

  # TODO: improve password validation (maybe NotQwerty123 or zxcvbn)
  @spec validate_password(Changeset.t()) :: Changeset.t()
  defp validate_password(changeset) do
    changeset
    |> validate_length(:password, @password_len)
    |> prepare_changes(&put_password_hash/1)
  end

  @spec put_password_hash(Changeset.t()) :: Changeset.t()
  defp put_password_hash(changeset) do
    password = get_change(changeset, :password)

    changeset
    |> put_change(:password_hash, Argon2.hash_pwd_salt(password))
    |> delete_change(:password)
  end
end
