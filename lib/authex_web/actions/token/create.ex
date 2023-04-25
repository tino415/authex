defmodule AuthexWeb.Actions.Token.Create do
  use Web.Action do
    plug(AuthexWeb.Plugs.BasicClientAuthentication)
  end

  @impl true
  def run(conn, _opts) do
    case Authex.create_token(conn.assigns.current_client) do
      {:ok, token} -> json_resp(conn, 201, token)
      {:error, _changeset} -> json_resp(conn, 403, %{"error" => "invalid data"})
    end
  end
end
