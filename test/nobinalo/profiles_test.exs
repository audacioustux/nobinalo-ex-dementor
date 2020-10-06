defmodule Nobinalo.ProfilesTest do
  use Nobinalo.DataCase

  alias Nobinalo.Profiles

  describe "profiles" do
    alias Nobinalo.Profiles.Profile

    @valid_attrs %{
      about: "some about",
      gender: "some gender",
      handle: "some handle",
      preferences: %{}
    }
    @update_attrs %{
      about: "some updated about",
      gender: "some updated gender",
      handle: "some updated handle",
      preferences: %{}
    }
    @invalid_attrs %{about: nil, gender: nil, handle: nil, preferences: nil}

    def profile_fixture(attrs \\ %{}) do
      {:ok, profile} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Profiles.create_profile()

      profile
    end

    test "list_profiles/0 returns all profiles" do
      profile = profile_fixture()
      assert Profiles.list_profiles() == [profile]
    end

    test "get_profile!/1 returns the profile with given id" do
      profile = profile_fixture()
      assert Profiles.get_profile!(profile.id) == profile
    end

    test "create_profile/1 with valid data creates a profile" do
      assert {:ok, %Profile{} = profile} = Profiles.create_profile(@valid_attrs)
      assert profile.about == "some about"
      assert profile.gender == "some gender"
      assert profile.handle == "some handle"
      assert profile.preferences == %{}
    end

    test "create_profile/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               Profiles.create_profile(@invalid_attrs)
    end

    test "update_profile/2 with valid data updates the profile" do
      profile = profile_fixture()

      assert {:ok, %Profile{} = profile} =
               Profiles.update_profile(profile, @update_attrs)

      assert profile.about == "some updated about"
      assert profile.gender == "some updated gender"
      assert profile.handle == "some updated handle"
      assert profile.preferences == %{}
    end

    test "update_profile/2 with invalid data returns error changeset" do
      profile = profile_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Profiles.update_profile(profile, @invalid_attrs)

      assert profile == Profiles.get_profile!(profile.id)
    end

    test "delete_profile/1 deletes the profile" do
      profile = profile_fixture()
      assert {:ok, %Profile{}} = Profiles.delete_profile(profile)

      assert_raise Ecto.NoResultsError, fn ->
        Profiles.get_profile!(profile.id)
      end
    end

    test "change_profile/1 returns a profile changeset" do
      profile = profile_fixture()
      assert %Ecto.Changeset{} = Profiles.change_profile(profile)
    end
  end
end
