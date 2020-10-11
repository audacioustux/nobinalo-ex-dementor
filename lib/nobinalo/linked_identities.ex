defmodule Nobinalo.LinkedIdentities do
  @moduledoc """
  The LinkedIdentities context.
  """

  import Ecto.Query, warn: false
  alias Nobinalo.Repo

  alias Nobinalo.LinkedIdentities.LinkedIdentity

  def create_or_update!(attrs \\ %{}) do
    %LinkedIdentity{}
    |> LinkedIdentity.create_changeset(attrs)
    |> Repo.insert!(
      conflict_target: [:provider, :uid],
      on_conflict: :replace_all
    )
  end
end
