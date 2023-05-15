defmodule AuthexWeb.Actions.Scope.Update do
  use AuthexWeb.Meta.Action.Update,
    name: "scope_id",
    do: plug(AuthexWeb.Middlewares.VerifyScopes, ["oauth:scope:update"])

  @impl true
  def update(conn, scope_id, body_params) do
    with %{} = scope <- Authex.get_scope(scope_id),
         {:ok, scope} <- Authex.update_scope(scope, body_params) do
      View.success(conn, scope)
    end
  end
end
