defmodule AuthexWeb.Actions.Client.Update do
  use Web.Action.Update, [name: "client_id", do: (
    plug AuthexWeb.Plugs.VerifyScopes, ["oauth:client:update"]
  )]

  @impl true
  def update(conn, client_id, body_params) do
    case Authex.get_client(client_id) do
      nil -> View.not_found(conn)
      client ->
        case Authex.update_client(client, body_params) do
          {:ok, client} -> View.success(conn, client)
          _ -> View.invalid_request(conn)
        end
    end
  end
end
