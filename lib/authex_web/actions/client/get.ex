defmodule AuthexWeb.Actions.Client.Get do
  use Web.Action do
    plug AuthexWeb.Plugs.VerifyScopes, ["oauth:client:read"]
  end

  @impl true
  def run(conn, _opts) do
    case Authex.get_client(conn.path_params["client_id"]) do
      nil -> json_resp(conn, 404, %{"error" => "not found"})
      client -> json_resp(conn, 200, client)
    end
  end
end
