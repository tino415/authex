defmodule AuthexWeb.Actions.Token.Create do
  use Web.Action do
    plug(AuthexWeb.Plugs.BasicClientAuthentication)
  end

  @impl true
  def run(conn) do
    case Authex.create_token(conn.assigns.current_client) do
      {:ok, token} -> View.created(conn, token)
      {:error, _changeset} -> View.invalid_request(conn)
    end
  end
end
