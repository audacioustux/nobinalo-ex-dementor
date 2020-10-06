defmodule Nobinalo.LinkedIdentities do
  @moduledoc """
  The LinkedIdentities context.
  """

  import Ecto.Query, warn: false
  alias Nobinalo.Repo

  alias Nobinalo.LinkedIdentities.LinkedIdentity

  @doc """
  Returns the list of linked_identity.

  ## Examples

      iex> list_linked_identity()
      [%LinkedIdentity{}, ...]

  """
  def list_linked_identity do
    Repo.all(LinkedIdentity)
  end

  @doc """
  Gets a single linked_identity.

  Raises `Ecto.NoResultsError` if the Linked identity does not exist.

  ## Examples

      iex> get_linked_identity!(123)
      %LinkedIdentity{}

      iex> get_linked_identity!(456)
      ** (Ecto.NoResultsError)

  """
  def get_linked_identity!(id) do
    Repo.get!(LinkedIdentity, id)
  end

  @doc """
  Creates a linked_identity.

  ## Examples

      iex> create_linked_identity(%{field: value})
      {:ok, %LinkedIdentity{}}

      iex> create_linked_identity(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_linked_identity(attrs \\ %{}) do
    %LinkedIdentity{}
  end

  @doc """
  Updates a linked_identity.

  ## Examples

      iex> update_linked_identity(linked_identity, %{field: new_value})
      {:ok, %LinkedIdentity{}}

      iex> update_linked_identity(linked_identity, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_linked_identity(%LinkedIdentity{} = linked_identity, attrs) do
    linked_identity
    |> LinkedIdentity.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a linked_identity.

  ## Examples

      iex> delete_linked_identity(linked_identity)
      {:ok, %LinkedIdentity{}}

      iex> delete_linked_identity(linked_identity)
      {:error, %Ecto.Changeset{}}

  """
  def delete_linked_identity(%LinkedIdentity{} = linked_identity) do
    Repo.delete(linked_identity)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking linked_identity changes.

  ## Examples

      iex> change_linked_identity(linked_identity)
      %Ecto.Changeset{data: %LinkedIdentity{}}

  """
  def change_linked_identity(%LinkedIdentity{} = linked_identity, attrs \\ %{}) do
  end
end
