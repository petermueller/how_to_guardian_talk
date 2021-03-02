defmodule MyAppWeb.PageController do
  use MyAppWeb, :controller

  def index(conn, _params) do
    conn
    |> assign(:current_user, MyAppWeb.Guardian.Plug.current_resource(conn))
    |> render("index.html")
  end
end
