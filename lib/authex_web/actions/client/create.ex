defmodule AuthexWeb.Actions.Client.Create do
  use AuthexWeb.Meta.Action.Create do
    plug AuthexWeb.Plugs.VerifyScopes, ["oauth:client:create"]
  end

  @impl true
  def create(conn, body_params) do
    case Authex.create_client(body_params) do
      {:ok, client} -> View.created(conn, client)
      {:error, changeset} -> View.invalid_request(conn, changeset)
    end
  end
end
