defmodule NobinaloWeb.AccountView do
  use NobinaloWeb, :view
  alias NobinaloWeb.AccountView

  def render("index.json", %{accounts: accounts}) do
    %{data: render_many(accounts, AccountView, "account.json")}
  end

  def render("show.json", %{account: account}) do
    %{data: render_one(account, AccountView, "account.json")}
  end

  def render("account.json", %{account: account}) do
    %{
      id: account.id,
      display_name: account.display_name,
      password_hash: account.password_hash,
      is_active: account.is_active
    }
  end
end
