defmodule AuthexWeb.Controllers.User do
  use Web.Controller

  def list(conn, params) do
    case Pagination.cast_pagination(params) do
      {:ok, pagination} -> json_resp(conn, 200, Authex.list_users(pagination))
      _ -> json_resp(conn, 403, %{"error" => "invalid data"})
    end
  end

  def get(conn, user_id) do
    case Authex.get_user(user_id) do
      nil -> json_resp(conn, 404, %{"error" => "not found"})
      user -> json_resp(conn, 200, user)
    end
  end

  def create(conn, params) do
    case Authex.create_user(params) do
      {:ok, user} -> json_resp(conn, 200, user)
      {:error, _changeset} -> json_resp(conn, 403, %{"error" => "invalid data"})
    end
  end

  def update(conn, user_id, params) do
    case Authex.get_user(user_id) do
      nil -> json_resp(conn, 404, %{"error" => "not found"})
      user ->
        case Authex.update_user(user, params) do
          {:ok, user} -> json_resp(conn, 200, user)
          _ -> json_resp(conn, 403, %{"error" => "invalid data"})
        end
    end
  end

  def delete(conn, user_id) do
    case Authex.get_user(user_id) do
      nil -> json_resp(conn, 404, %{"error" => "not found"})
      user ->
        case Authex.delete_user(user) do
          {:ok, user} -> json_resp(conn, 200, user)
          _ -> json_resp(conn, 500, %{"message" => "internal server error"})
        end
    end
  end
end
