defmodule Nobinalo.LinkedIdentitiesTest do
  use Nobinalo.DataCase

  alias Nobinalo.LinkedIdentities

  describe "linked_identity" do
    alias Nobinalo.LinkedIdentities.LinkedIdentity

    @valid_attrs %{
      access_token: "some access_token",
      provider: "some provider",
      raw_response: %{},
      uid: "some uid"
    }
    @update_attrs %{
      access_token: "some updated access_token",
      provider: "some updated provider",
      raw_response: %{},
      uid: "some updated uid"
    }
    @invalid_attrs %{
      access_token: nil,
      provider: nil,
      raw_response: nil,
      uid: nil
    }

    def linked_identity_fixture(attrs \\ %{}) do
      {:ok, linked_identity} =
        attrs
        |> Enum.into(@valid_attrs)
        |> LinkedIdentities.create_linked_identity()

      linked_identity
    end

    test "list_linked_identity/0 returns all linked_identity" do
      linked_identity = linked_identity_fixture()
      assert LinkedIdentities.list_linked_identity() == [linked_identity]
    end

    test "get_linked_identity!/1 returns the linked_identity with given id" do
      linked_identity = linked_identity_fixture()

      assert LinkedIdentities.get_linked_identity!(linked_identity.id) ==
               linked_identity
    end

    test "create_linked_identity/1 with valid data creates a linked_identity" do
      assert {:ok, %LinkedIdentity{} = linked_identity} =
               LinkedIdentities.create_linked_identity(@valid_attrs)

      assert linked_identity.access_token == "some access_token"
      assert linked_identity.provider == "some provider"
      assert linked_identity.raw_response == %{}
      assert linked_identity.uid == "some uid"
    end

    test "create_linked_identity/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               LinkedIdentities.create_linked_identity(@invalid_attrs)
    end

    test "update_linked_identity/2 with valid data updates the linked_identity" do
      linked_identity = linked_identity_fixture()

      assert {:ok, %LinkedIdentity{} = linked_identity} =
               LinkedIdentities.update_linked_identity(
                 linked_identity,
                 @update_attrs
               )

      assert linked_identity.access_token == "some updated access_token"
      assert linked_identity.provider == "some updated provider"
      assert linked_identity.raw_response == %{}
      assert linked_identity.uid == "some updated uid"
    end

    test "update_linked_identity/2 with invalid data returns error changeset" do
      linked_identity = linked_identity_fixture()

      assert {:error, %Ecto.Changeset{}} =
               LinkedIdentities.update_linked_identity(
                 linked_identity,
                 @invalid_attrs
               )

      assert linked_identity ==
               LinkedIdentities.get_linked_identity!(linked_identity.id)
    end

    test "delete_linked_identity/1 deletes the linked_identity" do
      linked_identity = linked_identity_fixture()

      assert {:ok, %LinkedIdentity{}} =
               LinkedIdentities.delete_linked_identity(linked_identity)

      assert_raise Ecto.NoResultsError, fn ->
        LinkedIdentities.get_linked_identity!(linked_identity.id)
      end
    end

    test "change_linked_identity/1 returns a linked_identity changeset" do
      linked_identity = linked_identity_fixture()

      assert %Ecto.Changeset{} =
               LinkedIdentities.change_linked_identity(linked_identity)
    end
  end
end
