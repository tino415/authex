defmodule AuthexWeb.Actions.Client.Delete do
  use AuthexWeb.Meta.Action.Delete,
    name: "client_id",
    do: plug(AuthexWeb.Plugs.VerifyScopes, ["oauth:client:delete"])

  @impl true
  def delete(conn, client_id) do
    case Authex.get_client(client_id) do
      nil -> View.not_found(conn)
      client -> View.success(conn, Authex.delete_client!(client))
    end
  end
end
