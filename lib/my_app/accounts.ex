defmodule MyApp.Accounts do
  @moduledoc """
  A fake/example context for doing account-related things
  """

  alias MyApp.{Repo, User}

  @peter %User{
    id: "peters_uuid",
    email: "peter@example.com",
    password_digest: "some_garbled_passwordasdfas;fsjhlk"
  }

  def get_user(id) when id == @peter.id do
    @peter
  end

  def get_user(_id) do
    nil
  end

  def get_user_by(%{"email" => "peter@example.com"}) do
    @peter
  end

  def get_user_by(_anything_else) do
    nil
  end

  # * What you'd typically write if this weren't a talk
  def get_user_by(params) do
    # ! Don't just blindly allow these to be used with parameter validation
    # ! Use an Ecto changeset, or write some logic to restrict what they can get users by.
    Repo.get_by(User, params)
  end

  def get_user_by_email_and_verify_password(params) do
    # ! OMG, really, don't do this. Sanitize your parameters. Just for demo purposes
    case get_user_by(params) do
      nil -> fake_verify_password()
      user -> verify_password(user, params["password"])
    end
  end

  def fake_verify_password do
    # waste some IO time. Use `Comeonin`
  end

  def verify_password(user, "password!") do
    user
  end

  def verify_password(_user, _password) do
    nil
  end
end
