defmodule AuthexWeb.Actions.User.Create do
  use AuthexWeb.Meta.Action.Create do
    plug(AuthexWeb.Plugs.VerifyScopes, ["oauth:user:create"])
  end

  @impl true
  def create(conn, body_params) do
    with {:ok, user} <- Authex.create_user(body_params) do
      View.created(conn, user)
    end
  end
end
