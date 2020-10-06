defmodule NobinaloWeb.AccountControllerTest do
  use NobinaloWeb.ConnCase

  alias Nobinalo.Accounts
  alias Nobinalo.Accounts.Account

  @create_attrs %{
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

  def fixture(:account) do
    {:ok, account} = Accounts.create_account(@create_attrs)
    account
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all accounts", %{conn: conn} do
      conn = get(conn, Routes.account_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create account" do
    test "renders account when data is valid", %{conn: conn} do
      conn =
        post(conn, Routes.account_path(conn, :create), account: @create_attrs)

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.account_path(conn, :show, id))

      assert %{
               "id" => id,
               "display_name" => "some display_name",
               "is_active" => true,
               "password_hash" => "some password_hash"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn =
        post(conn, Routes.account_path(conn, :create), account: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update account" do
    setup [:create_account]

    test "renders account when data is valid", %{
      conn: conn,
      account: %Account{id: id} = account
    } do
      conn =
        put(conn, Routes.account_path(conn, :update, account),
          account: @update_attrs
        )

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.account_path(conn, :show, id))

      assert %{
               "id" => id,
               "display_name" => "some updated display_name",
               "is_active" => false,
               "password_hash" => "some updated password_hash"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, account: account} do
      conn =
        put(conn, Routes.account_path(conn, :update, account),
          account: @invalid_attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete account" do
    setup [:create_account]

    test "deletes chosen account", %{conn: conn, account: account} do
      conn = delete(conn, Routes.account_path(conn, :delete, account))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.account_path(conn, :show, account))
      end
    end
  end

  defp create_account(_) do
    account = fixture(:account)
    %{account: account}
  end
end
