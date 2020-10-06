defmodule NobinaloWeb.PageController do
  use NobinaloWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
