defmodule AuthexWeb.Actions.Scope.Delete do
  use AuthexWeb.Meta.Action.Delete,
    name: "scope_id",
    do: plug(AuthexWeb.Middlewares.VerifyScopes, ["oauth:scope:delete"])

  @impl true
  def delete(conn, scope_id) do
    with %{} = scope <- Authex.get_scope(scope_id),
         {:ok, scope} <- Authex.delete_scope(scope) do
      View.success(conn, scope)
    end
  end
end
