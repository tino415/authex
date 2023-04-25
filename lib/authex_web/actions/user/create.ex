defmodule AuthexWeb.Actions.User.Create do
  use Web.Action

  @impl true
  def run(conn, _opts) do
    case Authex.create_user(conn.body_params) do
      {:ok, user} -> json_resp(conn, 200, user)
      {:error, _changeset} -> json_resp(conn, 403, %{"error" => "invalid data"})
    end
  end
end
