defmodule AuthexWeb.Actions.User.Get do
  use AuthexWeb.Meta.Action.Get,
    name: "user_id",
    do: plug(AuthexWeb.Plugs.VerifyScopes, ["oauth:user:read"])

  @impl true
  def get(conn, user_id) do
    case Authex.get_user(user_id) do
      nil -> View.not_found(conn)
      user -> View.success(conn, user)
    end
  end
end
