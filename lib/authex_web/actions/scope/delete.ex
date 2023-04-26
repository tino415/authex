defmodule AuthexWeb.Actions.Scope.Delete do
  use AuthexWeb.Meta.Action.Delete, [name: "scope_id", do: (
    plug AuthexWeb.Plugs.VerifyScopes, ["oauth:scope:delete"]
  )]


  @impl true
  def delete(conn, scope_id) do
    case Authex.get_scope(scope_id) do
      nil -> View.not_found(conn)
      scope ->
        case Authex.delete_scope(scope) do
          {:ok, scope} -> View.success(conn, scope)
          _ -> View.internal_server_error(conn)
        end
    end
  end
end
