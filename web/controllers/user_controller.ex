defmodule Rumbl.UserController do
  use Rumbl.Web, :controller

  alias Rumbl.User

  def index(conn, _params) do
    users = Repo.all(User)
    render conn, :index, users: users
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    render conn, :show, user: user
  end
end
