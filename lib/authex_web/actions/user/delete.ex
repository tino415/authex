defmodule AuthexWeb.Actions.User.Delete do
  use Web.Action

  @impl true
  def run(conn, _opts) do
    case Authex.get_user(conn.path_params["user_id"]) do
      nil -> json_resp(conn, 404, %{"error" => "not found"})
      user ->
        case Authex.delete_user(user) do
          {:ok, user} -> json_resp(conn, 200, user)
          _ -> json_resp(conn, 500, %{"message" => "internal server error"})
        end
    end
  end
end
