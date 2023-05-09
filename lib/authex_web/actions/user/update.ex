defmodule AuthexWeb.Actions.User.Update do
  use AuthexWeb.Meta.Action.Update,
    name: "user_id",
    do: plug(AuthexWeb.Plugs.VerifyScopes, ["oauth:user:update"])

  @impl true
  def update(conn, user_id, body_params) do
    case Authex.get_user(user_id) do
      nil ->
        View.not_found(conn)

      user ->
        case Authex.update_user(user, body_params) do
          {:ok, user} -> View.success(conn, user)
          {:error, changeset} -> View.invalid_request(conn, changeset)
        end
    end
  end
end
