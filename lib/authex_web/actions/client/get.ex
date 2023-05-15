defmodule AuthexWeb.Actions.Client.Get do
  use AuthexWeb.Meta.Action.Get,
    name: "client_id",
    do: plug(AuthexWeb.Plugs.VerifyScopes, ["oauth:client:read"])

  @impl true
  def get(conn, client_id) do
    with %{} = client <- Authex.get_client(client_id) do
      View.success(conn, client)
    end
  end
end
