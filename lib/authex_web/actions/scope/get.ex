defmodule AuthexWeb.Actions.Scope.Get do
  use AuthexWeb.Meta.Action.Get,
    name: "scope_id",
    do: plug(AuthexWeb.Middlewares.VerifyScopes, ["oauth:scope:read"])

  @impl true
  def get(conn, scope_id) do
    with %{} = scope <- Authex.get_scope(scope_id) do
      View.success(conn, scope)
    end
  end
end
