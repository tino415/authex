defmodule AuthexWeb.Actions.User.Update do
  use Web.Action

  @impl true
  def run(conn, _opts) do
    case Authex.get_user(conn.path_params["user_id"]) do
      nil -> json_resp(conn, 404, %{"error" => "not found"})
      user ->
        case Authex.update_user(user, conn.body_params) do
          {:ok, user} -> json_resp(conn, 200, user)
          _ -> json_resp(conn, 403, %{"error" => "invalid data"})
        end
    end
  end
end
