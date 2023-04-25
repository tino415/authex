defmodule AuthexWeb.Actions.Client.Create do
  use Web.Action do
    plug AuthexWeb.Plugs.VerifyScopes, ["oauth:client:create"]
  end

  @impl true
  def run(conn, _opts) do
    case Authex.create_client(conn.body_params) do
      {:ok, client} -> json_resp(conn, 200, client)
      {:error, _changeset} -> json_resp(conn, 403, %{"error" => "invalid data"})
    end
  end
end
