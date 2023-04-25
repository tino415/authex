defmodule AuthexWeb.Actions.Scope.Get do
  use Web.Action

  @impl true
  def run(conn, _opts) do
    case Authex.get_scope(conn.path_params["scope_id"]) do
      nil -> json_resp(conn, 404, %{"error" => "not found"})
      scope -> json_resp(conn, 200, scope)
    end
  end
end
