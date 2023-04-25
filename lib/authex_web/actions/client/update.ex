defmodule AuthexWeb.Actions.Client.Update do
  use Web.Action.Update, [name: "client_id", do: (
    plug AuthexWeb.Plugs.VerifyScopes, ["oauth:client:update"]
  )]

  @impl true
  def update(conn, client_id, body_params) do
    with %{} = client = Authex.get_client(client_id),
         {:ok, client} <- Authex.update_client(client, body_params) do
      View.success(conn, client)
    else
      nil ->
        View.not_found(conn)

      {:error, changeset} ->
        View.invalid_request(conn, changeset)
    end
  end
end
