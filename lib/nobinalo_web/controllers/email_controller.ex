defmodule NobinaloWeb.EmailController do
  use NobinaloWeb, :controller

  alias Nobinalo.Emails
  alias Nobinalo.Emails.Email

  action_fallback NobinaloWeb.FallbackController

  def index(conn, _params) do
    emails = Emails.list_emails()
    render(conn, "index.json", emails: emails)
  end

  def create(conn, %{"email" => email_params}) do
    with {:ok, %Email{} = email} <- Emails.create_email(email_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.email_path(conn, :show, email))
      |> render("show.json", email: email)
    end
  end

  def show(conn, %{"id" => id}) do
    email = Emails.get_email!(id)
    render(conn, "show.json", email: email)
  end

  def update(conn, %{"id" => id, "email" => email_params}) do
    email = Emails.get_email!(id)

    with {:ok, %Email{} = email} <- Emails.update_email(email, email_params) do
      render(conn, "show.json", email: email)
    end
  end

  def delete(conn, %{"id" => id}) do
    email = Emails.get_email!(id)

    with {:ok, %Email{}} <- Emails.delete_email(email) do
      send_resp(conn, :no_content, "")
    end
  end
end
