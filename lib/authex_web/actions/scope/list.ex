defmodule AuthexWeb.Actions.Scope.List do
  use Web.Action

  @impl true
  def run(conn, _opts) do
    case Pagination.cast_pagination(conn.quote_params) do
      {:ok, pagination} -> json_resp(conn, 200, Authex.list_scopes(pagination))
      _ -> json_resp(conn, 403, %{"error" => "invalid data"})
    end
  end

end
