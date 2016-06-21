defmodule Rumbl.UserController do
  use Rumbl.Web, :controller

  alias Rumbl.User

  plug :scrub_params, "user" when action in [:create]

  def index(conn, _params) do
    users = Repo.all(User)
    render conn, :index, users: users
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    render conn, :show, user: user
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, :new, changeset: changeset
  end

  def create(conn, %{"user" => user}) do
    changeset = User.changeset(%User{}, user)
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn 
        |> put_flash(:info, "Welcome to Rumbl.io #{user.username}!")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        render conn, :new, changeset: changeset
    end
  end
end
