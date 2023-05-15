defmodule AuthexWeb.Actions.Scope.Create do
  use AuthexWeb.Meta.Action.Create do
    plug(AuthexWeb.Plugs.VerifyScopes, ["oauth:scope:create"])
  end

  @impl true
  def create(conn, body_params) do
    with {:ok, scope} <- Authex.create_scope(body_params) do
      View.created(conn, scope)
    end
  end
end
