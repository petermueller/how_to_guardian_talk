defmodule MyAppWeb.DebugController do
  use MyAppWeb, :controller

  def show(conn, _params) do
    conn
    |> put_format(:json)
    |> put_resp_content_type("application/json")
    |> json(%{
      assigns: conn.assigns,
      session: get_session(conn),
      cookies: conn.cookies,
      guardian: %{
        claims: MyAppWeb.Guardian.Plug.current_claims(conn),
        token: MyAppWeb.Guardian.Plug.current_token(conn),
        resource: map_if_resource(MyAppWeb.Guardian.Plug.current_resource(conn))
      }
    })
  end

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {_type, _reason}, _opts) do
    text(conn, inspect(conn))
  end

  def map_if_resource(nil), do: nil

  def map_if_resource(user) do
    Map.take(user, [
      :id,
      :email,
      :password_digest
    ])
  end
end
