defmodule AuthexWeb.Actions.Scope.Update do
  use AuthexWeb.Meta.Action.Update, [name: "scope_id", do: (
    plug AuthexWeb.Plugs.VerifyScopes, ["oauth:scope:update"]
  )]


  @impl true
  def update(conn, scope_id, body_params) do
    case Authex.get_scope(scope_id) do
      nil -> View.not_found(conn)
      scope ->
        case Authex.update_scope(scope, body_params) do
          {:ok, scope} -> View.success(conn, scope)
          {:error, changeset} -> View.invalid_request(conn, changeset)
        end
    end
  end
end
