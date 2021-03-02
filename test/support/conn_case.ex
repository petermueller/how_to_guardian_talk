defmodule MyAppWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use MyAppWeb.ConnCase, async: true`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate

  @default_opts [
    store: :cookie,
    key: "_my_app_key",
    signing_salt: "09ApxCiB"
  ]

  @signing_opts Plug.Session.init(Keyword.put(@default_opts, :encrypt, false))

  using do
    quote do
      # Import conveniences for testing with connections
      import Plug.Conn
      import Phoenix.ConnTest
      import MyAppWeb.ConnCase

      alias MyAppWeb.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint MyAppWeb.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(MyApp.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(MyApp.Repo, {:shared, self()})
    end

    metadata =
      case tags[:authenticated] do
        user when user == :user or user == true ->
          user = %MyApp.User{
            id: "peters_uuid",
            email: "peter@example.com",
            password_digest: "aasdfasdfasdfsdfsdf"
          }

          authed_session =
            Phoenix.ConnTest.build_conn()
            |> Plug.Session.call(@signing_opts)
            |> Plug.Conn.fetch_session()
            |> MyAppWeb.Guardian.Plug.sign_in(user)
            |> Plug.Conn.get_session()

          conn =
            Phoenix.ConnTest.build_conn()
            |> Phoenix.ConnTest.init_test_session(authed_session)

          [conn: conn, user: user]

        :admin ->
          user = %MyApp.User{
            id: "peters_uuid",
            email: "admin@example.com",
            password_digest: "aasdfasdfasdfsdfsdf"
          }

          authed_session =
            Phoenix.ConnTest.build_conn()
            |> Plug.Session.call(@signing_opts)
            |> Plug.Conn.fetch_session()
            |> MyAppWeb.Guardian.Plug.sign_in(user, %{"roles" => ["admin"]})
            |> Plug.Conn.get_session()

          conn =
            Phoenix.ConnTest.build_conn()
            |> Phoenix.ConnTest.init_test_session(authed_session)

          [conn: conn, user: user]

        _other ->
          [conn: Phoenix.ConnTest.build_conn()]
      end

    {:ok, metadata}
  end
end
