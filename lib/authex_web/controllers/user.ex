defmodule AuthexWeb.Controllers.User do
  use Web.Controller

  def create(conn) do
    case Authex.create_user(conn.params) |> IO.inspect(label: "create") do
      {:ok, user} -> json_resp(conn, 200, user)
      {:error, _changeset} -> json_resp(conn, 403, %{"error" => "invalid data"})
    end
  end

  def get(conn) do
    case Authex.get_user(conn.params["user_id"]) do
      nil -> json_resp(conn, 404, %{"error" => "not found"})
      user -> json_resp(conn, 200, user)
    end
  end
end
