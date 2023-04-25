defmodule AuthexWeb.Actions.Client.Create do
  use Web.Action.Create do
    plug AuthexWeb.Plugs.VerifyScopes, ["oauth:client:create"]
  end

  @impl true
  def create(conn, body_params) do
    case Authex.create_client(body_params) do
      {:ok, client} -> View.created(conn, client)
      {:error, _changeset} -> View.invalid_request(conn)
    end
  end
end
