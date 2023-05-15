defmodule AuthexWeb.Actions.User.Update do
  use AuthexWeb.Meta.Action.Update,
    name: "user_id",
    do: plug(AuthexWeb.Plugs.VerifyScopes, ["oauth:user:update"])

  @impl true
  def update(conn, user_id, body_params) do
    with %{} = user <- Authex.get_user(user_id),
         {:ok, user} <- Authex.update_user(user, body_params) do
      View.success(conn, user)
    end
  end
end
