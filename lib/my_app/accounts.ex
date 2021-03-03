defmodule MyApp.Accounts do
  @moduledoc """
  A fake/example context for doing account-related things
  """

  alias MyApp.{Repo, User}

  @peter %User{
    id: "peters_uuid",
    email: "peter@example.com",
    password_digest: "some_garbled_passwordasdfas;fsjhlk",
    is_admin: false
  }

  @admin %User{
    id: "admin_uuid",
    email: "admin@example.com",
    password_digest: "some_garbled_passwordasdfas;fsjhlk",
    is_admin: true
  }

  @users [@peter, @admin]

  @valid_keys ["email", "is_admin"]

  def get_user(id) do
    Enum.find(@users, &(&1.id == id))
  end

  def get_user_by(params) do
    params = validate_params(params)

    Enum.find(@users, fn user ->
      Enum.all?(params, fn {k, v} ->
        k = String.to_existing_atom(k)
        Map.fetch!(user, k) == v
      end)
    end)
  end

  # * What you'd typically write if this weren't a talk
  def get_user_by(params) do
    # ! Use an Ecto changeset, or write some logic to restrict what they can get users by.
    # ! This is a "usable" approach, but probably not ideal.
    params = validate_params(params)
    Repo.get_by(User, params)
  end

  def get_user_by_email_and_verify_password(%{"password" => password} = params) do
    params = validate_params(params)

    case get_user_by(params) do
      nil -> fake_verify_password()
      user -> verify_password(user, password)
    end
  end

  def validate_params(params) do
    # ! OMG, really, don't do this. Sanitize your parameter values, not just the keys. Just for demo purposes
    # ! This returns an empty map if they give no valid params. SERIOUSLY, THIS IS A BAD IDEA. Do proper error-tuples.
    Map.take(params, @valid_keys)
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
