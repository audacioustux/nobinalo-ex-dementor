defmodule Nobinalo.EmailsTest do
  use Nobinalo.DataCase

  alias Nobinalo.Emails

  describe "emails" do
    alias Nobinalo.Emails.Email

    @valid_attrs %{
      email: "some email",
      is_backup: true,
      is_primary: true,
      is_public: true,
      verified_at: "2010-04-17T14:00:00.000000Z"
    }
    @update_attrs %{
      email: "some updated email",
      is_backup: false,
      is_primary: false,
      is_public: false,
      verified_at: "2011-05-18T15:01:01.000000Z"
    }
    @invalid_attrs %{
      email: nil,
      is_backup: nil,
      is_primary: nil,
      is_public: nil,
      verified_at: nil
    }

    def email_fixture(attrs \\ %{}) do
      {:ok, email} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Emails.create_email()

      email
    end

    test "list_emails/0 returns all emails" do
      email = email_fixture()
      assert Emails.list_emails() == [email]
    end

    test "get_email!/1 returns the email with given id" do
      email = email_fixture()
      assert Emails.get_email!(email.id) == email
    end

    test "create_email/1 with valid data creates a email" do
      assert {:ok, %Email{} = email} = Emails.create_email(@valid_attrs)
      assert email.email == "some email"
      assert email.is_backup == true
      assert email.is_primary == true
      assert email.is_public == true

      assert email.verified_at ==
               DateTime.from_naive!(~N[2010-04-17T14:00:00.000000Z], "Etc/UTC")
    end

    test "create_email/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Emails.create_email(@invalid_attrs)
    end

    test "update_email/2 with valid data updates the email" do
      email = email_fixture()
      assert {:ok, %Email{} = email} = Emails.update_email(email, @update_attrs)
      assert email.email == "some updated email"
      assert email.is_backup == false
      assert email.is_primary == false
      assert email.is_public == false

      assert email.verified_at ==
               DateTime.from_naive!(~N[2011-05-18T15:01:01.000000Z], "Etc/UTC")
    end

    test "update_email/2 with invalid data returns error changeset" do
      email = email_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Emails.update_email(email, @invalid_attrs)

      assert email == Emails.get_email!(email.id)
    end

    test "delete_email/1 deletes the email" do
      email = email_fixture()
      assert {:ok, %Email{}} = Emails.delete_email(email)
      assert_raise Ecto.NoResultsError, fn -> Emails.get_email!(email.id) end
    end

    test "change_email/1 returns a email changeset" do
      email = email_fixture()
      assert %Ecto.Changeset{} = Emails.change_email(email)
    end
  end
end
