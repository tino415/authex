defmodule AuthexWeb.Actions.Client.Create do
  use AuthexWeb.Meta.Action.Create do
    plug(AuthexWeb.Plugs.VerifyScopes, ["oauth:client:create"])
  end

  @impl true
  def create(conn, body_params) do
    with {:ok, client} <- Authex.create_client(body_params) do
      View.created(conn, client)
    end
  end
end
