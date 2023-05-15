defmodule AuthexWeb.Actions.Client.Delete do
  use AuthexWeb.Meta.Action.Delete,
    name: "client_id",
    do: plug(AuthexWeb.Middlewares.VerifyScopes, ["oauth:client:delete"])

  @impl true
  def delete(conn, client_id) do
    with %{} = client <- Authex.get_client(client_id) do
      View.success(conn, Authex.delete_client!(client))
    end
  end
end
