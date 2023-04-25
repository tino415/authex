defmodule AuthexWeb.Actions.Client.Delete do
  use Web.Action do
    plug AuthexWeb.Plugs.VerifyScopes, ["oauth:client:delete"]
  end

  @impl true
  def run(conn, _opts) do
    case Authex.get_client(conn.path_params["client_id"]) do
      nil -> json_resp(conn, 404, %{"error" => "not found"})
      client ->
        case Authex.delete_client(client) do
          {:ok, client} -> json_resp(conn, 200, client)
          _ -> json_resp(conn, 403, %{"error" => "invalid data"})
        end
    end
  end
end
