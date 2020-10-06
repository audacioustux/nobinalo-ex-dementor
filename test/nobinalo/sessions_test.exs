defmodule Nobinalo.SessionsTest do
  use Nobinalo.DataCase

  alias Nobinalo.Sessions

  describe "sessions" do
    alias Nobinalo.Sessions.Session

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def session_fixture(attrs \\ %{}) do
      {:ok, session} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sessions.create_session()

      session
    end

    test "list_sessions/0 returns all sessions" do
      session = session_fixture()
      assert Sessions.list_sessions() == [session]
    end

    test "get_session!/1 returns the session with given id" do
      session = session_fixture()
      assert Sessions.get_session!(session.id) == session
    end

    test "create_session/1 with valid data creates a session" do
      assert {:ok, %Session{} = session} = Sessions.create_session(@valid_attrs)
    end

    test "create_session/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               Sessions.create_session(@invalid_attrs)
    end

    test "update_session/2 with valid data updates the session" do
      session = session_fixture()

      assert {:ok, %Session{} = session} =
               Sessions.update_session(session, @update_attrs)
    end

    test "update_session/2 with invalid data returns error changeset" do
      session = session_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Sessions.update_session(session, @invalid_attrs)

      assert session == Sessions.get_session!(session.id)
    end

    test "delete_session/1 deletes the session" do
      session = session_fixture()
      assert {:ok, %Session{}} = Sessions.delete_session(session)

      assert_raise Ecto.NoResultsError, fn ->
        Sessions.get_session!(session.id)
      end
    end

    test "change_session/1 returns a session changeset" do
      session = session_fixture()
      assert %Ecto.Changeset{} = Sessions.change_session(session)
    end
  end
end
