defmodule AuthexWeb.Actions.User.Get do
  use AuthexWeb.Meta.Action.Get,
    name: "user_id",
    do: plug(AuthexWeb.Middlewares.VerifyScopes, ["oauth:user:read"])

  @impl true
  def get(conn, user_id) do
    with %{} = user <- Authex.get_user(user_id) do
      View.success(conn, user)
    end
  end
end
