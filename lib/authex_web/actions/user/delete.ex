defmodule AuthexWeb.Actions.User.Delete do
  use AuthexWeb.Meta.Action.Delete,
    name: "user_id",
    do: plug(AuthexWeb.Middlewares.VerifyScopes, ["oauth:user:delete"])

  @impl true
  def delete(conn, user_id) do
    with %{} = user <- Authex.get_user(user_id) do
      View.success(conn, Authex.delete_user!(user))
    end
  end
end
