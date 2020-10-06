defmodule Nobinalo.Profiles.Profile do
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}

  alias Nobinalo.Accounts.Account
  alias Nobinalo.Files.Images.Image

  @display_name_len [min: 3, max: 48]

  schema "profiles" do
    field :about, :string
    field :gender, GenderEnum
    field :display_name, :string
    field :dob, :utc_datetime
    field :preferences, :map

    belongs_to(:account, Account, type: :binary_id)
    belongs_to(:cover, Image, type: :binary_id)
    belongs_to(:avatar, Image, type: :binary_id)

    timestamps()
  end

  @required_fields ~w[display_name]a
  @spec create_changeset(t, map) :: Changeset.t()
  def create_changeset(profile, attrs) do
    profile
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> validate_length(:display_name, @display_name_len)
  end
end
