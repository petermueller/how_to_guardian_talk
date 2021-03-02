defmodule MyAppWeb.UserPipeline do
  @moduledoc """
  The User Pipeline
  ensures the user from the session
  """
  use Guardian.Plug.Pipeline, otp_app: :my_app

  # plug Guardian.Plug.VerifySession, claims: %{"roles" => ["admin"]}
  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.LoadResource, allow_blank: true
end
