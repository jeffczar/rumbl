defmodule Rumbl.UserControllerTest do
  use Rumbl.ConnCase

  setup do
    # insert users into the database inside a transaction
    %User{name: "test_user_1", username: "test_username_1", password: "test_password_1"}
    %User{name: "test_user_2", username: "test_username_2", password: "test_password_2"}
    %User{name: "test_user_3", username: "test_username_3", password: "test_password_3"}
    %User{name: "test_user_4", username: "test_username_4", password: "test_password_4"}
  end
  
  test "GET /users", %{conn: conn} do
    conn = get conn, "/users"
    html_response(conn, 200) =~ ""
  end

end
