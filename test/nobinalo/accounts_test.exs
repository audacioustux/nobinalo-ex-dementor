defmodule Nobinalo.AccountsTest do
  use Nobinalo.DataCase

  alias Nobinalo.Accounts

  describe "accounts" do
    alias Nobinalo.Accounts.Account

    @valid_attrs %{
      display_name: "some display_name",
      is_active: true,
      password_hash: "some password_hash"
    }
    @update_attrs %{
      display_name: "some updated display_name",
      is_active: false,
      password_hash: "some updated password_hash"
    }
    @invalid_attrs %{display_name: nil, is_active: nil, password_hash: nil}

    def account_fixture(attrs \\ %{}) do
      {:ok, account} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_account()

      account
    end

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Accounts.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Accounts.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      assert {:ok, %Account{} = account} = Accounts.create_account(@valid_attrs)
      assert account.display_name == "some display_name"
      assert account.is_active == true
      assert account.password_hash == "some password_hash"
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               Accounts.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()

      assert {:ok, %Account{} = account} =
               Accounts.update_account(account, @update_attrs)

      assert account.display_name == "some updated display_name"
      assert account.is_active == false
      assert account.password_hash == "some updated password_hash"
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Accounts.update_account(account, @invalid_attrs)

      assert account == Accounts.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Accounts.delete_account(account)

      assert_raise Ecto.NoResultsError, fn ->
        Accounts.get_account!(account.id)
      end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Accounts.change_account(account)
    end
  end
end
