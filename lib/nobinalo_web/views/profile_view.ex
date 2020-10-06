defmodule NobinaloWeb.ProfileView do
  use NobinaloWeb, :view
  alias NobinaloWeb.ProfileView

  def render("index.json", %{profiles: profiles}) do
    %{data: render_many(profiles, ProfileView, "profile.json")}
  end

  def render("show.json", %{profile: profile}) do
    %{data: render_one(profile, ProfileView, "profile.json")}
  end

  def render("profile.json", %{profile: profile}) do
    %{
      id: profile.id,
      handle: profile.handle,
      gender: profile.gender,
      about: profile.about,
      preferences: profile.preferences
    }
  end
end
