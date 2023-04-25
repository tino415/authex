defmodule AuthexWeb.Actions.Scope.Delete do
  use Web.Action.Delete, name: "scope_id"

  @impl true
  def delete(conn, scope_id) do
    case Authex.get_scope(scope_id) do
      nil -> View.not_found(conn)
      scope ->
        case Authex.delete_scope(scope) do
          {:ok, scope} -> View.success(conn, scope)
          _ -> View.invalid_request(conn)
        end
    end
  end
end
