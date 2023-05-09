defmodule AuthexWeb.Actions.Scope.Get do
  use AuthexWeb.Meta.Action.Get,
    name: "scope_id",
    do: plug(AuthexWeb.Plugs.VerifyScopes, ["oauth:scope:read"])

  @impl true
  def get(conn, scope_id) do
    case Authex.get_scope(scope_id) do
      nil -> View.not_found(conn)
      scope -> View.success(conn, scope)
    end
  end
end
