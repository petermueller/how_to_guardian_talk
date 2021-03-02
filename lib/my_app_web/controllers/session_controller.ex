defmodule MyAppWeb.SessionController do
  use MyAppWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, params) do
    conn =
      case MyApp.Accounts.get_user_by_email_and_verify_password(params) do
        nil -> raise "not implemented yet"
        user -> MyAppWeb.Guardian.Plug.sign_in(conn, user)
      end

    conn
    |> put_flash(:info, "Signed In")
    |> redirect(to: Routes.page_path(conn, :index))
  end

  def delete(conn, _params) do
    conn = MyAppWeb.Guardian.Plug.sign_out(conn)

    conn
    |> put_flash(:info, "Signed Out")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
