defmodule MyAppWeb.PageControllerTest do
  use MyAppWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome anonymous person!"

    assert html_response(conn, 200) =~ "Sign In"
  end

  @tag :authenticated
  test "GET / as an authed user", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome peter@example.com"

    assert html_response(conn, 200) =~ "Sign Out"
  end

  @tag authenticated: :admin
  test "GET / as an authed admin user", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome admin@example.com!"
    # assert html_response(conn, 200) =~ "Click Here to do Admin things"

    assert html_response(conn, 200) =~ "Sign Out"
  end
end
