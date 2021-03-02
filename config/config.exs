# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :my_app,
  ecto_repos: [MyApp.Repo]

# Configures the endpoint
config :my_app, MyAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "IjZ7vag1/qYdMgE6KriD6nm+NFY+mE/a07XOFtifYKAn29Cm43RhLK6RaRFg0+Lb",
  render_errors: [view: MyAppWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: MyApp.PubSub,
  live_view: [signing_salt: "f+BwS014"]

config :my_app, MyAppWeb.Guardian,
  issuer: "my_app",
  secret_key: "Secret key. You can use `mix guardian.gen.secret` to get one"

config :my_app, MyAppWeb.UserPipeline,
  error_handler: MyAppWeb.SessionController,
  module: MyAppWeb.Guardian

# secret_key: "daHt+xTxEQZ4zLz+w04S2jz0spf0xXRT41yGdIgBSv1jYmqa0CCS/Q9IK3auo4lC"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
