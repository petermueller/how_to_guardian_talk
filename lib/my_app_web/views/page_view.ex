defmodule MyAppWeb.PageView do
  use MyAppWeb, :view

  def get_email(%{email: email}), do: email
  def get_email(_), do: nil
end
