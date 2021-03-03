defmodule MyAppWeb.GuardianError do
  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {_type, _reason}, _opts) do
    # ! Don't do this, should be handling it correctly
    conn
    |> Phoenix.Controller.text(inspect(conn))
    |> Plug.Conn.halt()
  end
end
