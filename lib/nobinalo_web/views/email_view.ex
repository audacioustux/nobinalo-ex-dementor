defmodule NobinaloWeb.EmailView do
  use NobinaloWeb, :view
  alias NobinaloWeb.EmailView

  def render("index.json", %{emails: emails}) do
    %{data: render_many(emails, EmailView, "email.json")}
  end

  def render("show.json", %{email: email}) do
    %{data: render_one(email, EmailView, "email.json")}
  end

  def render("email.json", %{email: email}) do
    %{
      id: email.id,
      email: email.email,
      is_primary: email.is_primary,
      is_public: email.is_public,
      is_backup: email.is_backup,
      verified_at: email.verified_at
    }
  end
end
