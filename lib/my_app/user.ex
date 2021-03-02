defmodule MyApp.User do
  use Ecto.Schema

  embedded_schema do
    field :email
    field :password_digest
  end
end
