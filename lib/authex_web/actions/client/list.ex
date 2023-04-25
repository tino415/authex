defmodule AuthexWeb.Actions.Client.List do
  use Web.Action do
    plug AuthexWeb.Plugs.VerifyScopes, ["oauth:client:read"]
  end

  @impl true
  def run(conn, _opts) do
    IO.puts("call")
    case Pagination.cast_pagination(conn.query_params) do
      {:ok, pagination} -> json_resp(conn, 200, Authex.list_clients(pagination))
      _ -> json_resp(conn, 403, %{"error" => "invalid data"})
    end
  end
end
