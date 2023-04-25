defmodule AuthexWeb.Actions.User.Get do
  use Web.Action

  @impl true
  def run(conn, _opts) do
    case Authex.get_user(conn.path_params["user_id"]) do
      nil -> json_resp(conn, 404, %{"error" => "not found"})
      user -> json_resp(conn, 200, user)
    end
  end
end
