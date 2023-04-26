defmodule AuthexWeb.Actions.Token.Create do
  use AuthexWeb.Meta.Action.Create do
    plug(AuthexWeb.Plugs.BasicClientAuthentication)
  end

  @impl true
  def create(conn, body_params) do
    case Authex.create_token(conn.assigns.current_client, body_params) do
      {:ok, token} -> View.created(conn, token)
      {:error, changeset} -> View.invalid_request(conn, changeset)
    end
  end
end
