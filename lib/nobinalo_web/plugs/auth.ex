defmodule NobinaloWeb.Auth do
  import Plug.Conn
  import Phoenix.Controller
  alias NobinaloWeb.Router.Helpers, as: Routes
  alias Nobinalo.Accounts

  def init(opts), do: opts
end
