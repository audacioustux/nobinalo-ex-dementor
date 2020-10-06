defmodule Nobinalo.Files.Images.Image do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  alias Nobinalo.Profiles.Profile

  @type t :: %__MODULE__{}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "images" do
    field :height, :integer
    field :mime, :string
    field :name, :string
    field :size, :integer
    field :varient, :string
    field :width, :integer

    belongs_to(:profile, Profile, type: :binary_id)

    timestamps()
  end

  @required_fields ~w[name size mime varient width height profile_id]a

  @spec create_changeset(t, map) :: Changeset.t()
  def create_changeset(image, attrs) do
    image
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
