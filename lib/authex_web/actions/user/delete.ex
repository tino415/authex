defmodule AuthexWeb.Actions.User.Delete do
  use Web.Action.Delete, [name: "user_id", do: (
    plug AuthexWeb.Plugs.VerifyScopes, ["oauth:user:delete"]
  )]

  @impl true
  def delete(conn, user_id) do
    case Authex.get_user(user_id) do
      nil -> View.not_found(conn)
      user ->
        case Authex.delete_user(user) do
          {:ok, user} -> View.success(conn, user)
          _ -> View.internal_server_error(conn)
        end
    end
  end
end
