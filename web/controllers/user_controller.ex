defmodule Rumbl.UserController do

  import Rumbl.Auth, only: [authenticate_user: 2]

  use Rumbl.Web, :controller

  alias Rumbl.User

  plug :scrub_params, "user" when action in [:create]
  plug :authenticate_user when action in [:index, :show]

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

  def create(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn 
        |> Rumbl.Auth.login(user)
        |> put_flash(:info, "Welcome to Rumbl.io #{user.username}!")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        render conn, :new, changeset: changeset
    end
  end
end
