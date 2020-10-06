defmodule NobinaloWeb.ProfileController do
  use NobinaloWeb, :controller

  alias Nobinalo.Profiles
  alias Nobinalo.Profiles.Profile

  action_fallback NobinaloWeb.FallbackController

  def index(conn, _params) do
    profiles = Profiles.list_profiles()
    render(conn, "index.json", profiles: profiles)
  end

  def create(conn, %{"profile" => profile_params}) do
    with {:ok, %Profile{} = profile} <- Profiles.create_profile(profile_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.profile_path(conn, :show, profile))
      |> render("show.json", profile: profile)
    end
  end

  def show(conn, %{"id" => id}) do
    profile = Profiles.get_profile!(id)
    render(conn, "show.json", profile: profile)
  end

  def update(conn, %{"id" => id, "profile" => profile_params}) do
    profile = Profiles.get_profile!(id)

    with {:ok, %Profile{} = profile} <-
           Profiles.update_profile(profile, profile_params) do
      render(conn, "show.json", profile: profile)
    end
  end

  def delete(conn, %{"id" => id}) do
    profile = Profiles.get_profile!(id)

    with {:ok, %Profile{}} <- Profiles.delete_profile(profile) do
      send_resp(conn, :no_content, "")
    end
  end
end
