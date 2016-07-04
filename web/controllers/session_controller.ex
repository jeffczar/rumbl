defmodule Rumbl.SessionController do
  use Rumbl.Web, :controller

  def new(conn, _opts) do
    render conn, :new
  end

  def create(conn, %{"session" => %{"username" => username, "password" => password}}) do
    result = Rumbl.Auth.login_with_username_and_password(conn, username, password, repo: Rumbl.Repo)
    case result do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome back #{username}")
        |> redirect(to: page_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid username/password combination")
        |> render(:new)
    end
  end

  def delete(conn, _opts) do
    conn
    |> Rumbl.Auth.logout()
    |> put_flash(:info, "You have been logged out.")
    |> redirect(to: page_path(conn, :index))
  end
end
