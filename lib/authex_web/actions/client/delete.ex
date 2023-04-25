defmodule AuthexWeb.Actions.Client.Delete do
  use Web.Action.Delete, [name: "client_id", do: (
    plug AuthexWeb.Plugs.VerifyScopes, ["oauth:client:delete"]
  )]

  @impl true
  def delete(conn, client_id) do
    case Authex.get_client(client_id) do
      nil -> View.not_found(conn)
      client ->
        case Authex.delete_client(client) do
          {:ok, client} -> View.success(conn, client)
          _ -> View.invalid_request(conn)
        end
    end
  end
end
