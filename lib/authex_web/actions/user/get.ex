defmodule AuthexWeb.Actions.User.Get do
  use Web.Action.Get, name: "scope_id"

  @impl true
  def get(conn, user_id) do
    case Authex.get_user(user_id) do
      nil -> View.not_found(conn)
      user -> View.success(conn, user)
    end
  end
end