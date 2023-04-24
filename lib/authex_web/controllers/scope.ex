defmodule AuthexWeb.Controllers.Scope do
  use Web.Controller

  def list(conn, params) do
    case Pagination.cast_pagination(params) do
      {:ok, pagination} -> json_resp(conn, 200, Authex.list_scopes(pagination))
      _ -> json_resp(conn, 403, %{"error" => "invalid data"})
    end
  end

  def get(conn, scope_id) do
    case Authex.get_scope(scope_id) do
      nil -> json_resp(conn, 404, %{"error" => "not found"})
      scope -> json_resp(conn, 200, scope)
    end
  end


  def create(conn, parameters) do
    case Authex.create_scope(parameters) do
      {:ok, scope} -> json_resp(conn, 201, scope)
      {:error, _} -> json_resp(conn, 422, %{"message" => "invalid_request"})
    end
  end

  def update(conn, scope_id, parameters) do
    case Authex.get_scope(scope_id) do
      nil -> json_resp(conn, 404, %{"message" => "not_found"})
      scope ->
        case Authex.update_scope(scope, parameters) do
          {:ok, scope} -> json_resp(conn, 200, scope)
          {:error, _} -> json_resp(conn, 400, %{"message" => "invalid_request"})
        end
    end
  end

  def delete(conn, scope_id) do
    case Authex.get_scope(scope_id) do
      nil -> json_resp(conn, 404, %{"message" => "not_found"})
      scope ->
        case Authex.delete_scope(scope) do
          {:ok, scope} -> json_resp(conn, 200, scope)
          _ -> json_resp(conn, 400, %{"message" => "invalid_request"})
        end
    end
  end
end
