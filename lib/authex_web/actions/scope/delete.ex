defmodule AuthexWeb.Actions.Scope.Delete do
  use Web.Action

  @impl true
  def run(conn, _opts) do
    case Authex.get_scope(conn.query_params["scope_id"]) do
      nil -> json_resp(conn, 404, %{"message" => "not_found"})
      scope ->
        case Authex.delete_scope(scope) do
          {:ok, scope} -> json_resp(conn, 200, scope)
          _ -> json_resp(conn, 400, %{"message" => "invalid_request"})
        end
    end
  end
end
