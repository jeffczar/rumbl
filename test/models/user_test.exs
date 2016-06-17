defmodule Rumbl.UserTest do
  use Rumbl.ModelCase
  
  alias Rumbl.User

  @valid_attrs %{name: "test_name", username: "test_username", password: "test"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
