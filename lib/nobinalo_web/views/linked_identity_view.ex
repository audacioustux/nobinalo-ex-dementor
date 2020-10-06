defmodule NobinaloWeb.LinkedIdentityView do
  use NobinaloWeb, :view
  alias NobinaloWeb.LinkedIdentityView

  def render("index.json", %{linked_identity: linked_identity}) do
    %{
      data:
        render_many(linked_identity, LinkedIdentityView, "linked_identity.json")
    }
  end

  def render("show.json", %{linked_identity: linked_identity}) do
    %{
      data:
        render_one(linked_identity, LinkedIdentityView, "linked_identity.json")
    }
  end

  def render("linked_identity.json", %{linked_identity: linked_identity}) do
    %{
      id: linked_identity.id,
      provider: linked_identity.provider,
      uid: linked_identity.uid,
      access_token: linked_identity.access_token,
      raw_response: linked_identity.raw_response
    }
  end
end
