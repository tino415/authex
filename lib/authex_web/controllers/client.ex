defmodule AuthexWeb.Controllers.Client do
  use Web.Controller

  def list(conn, params) do
    case Pagination.cast_pagination(params) do
      {:ok, pagination} -> json_resp(conn, 200, Authex.list_clients(pagination))
      _ -> json_resp(conn, 403, %{"error" => "invalid data"})
    end
  end

  def get(conn, client_id) do
    case Authex.get_client(client_id) do
      nil -> json_resp(conn, 404, %{"error" => "not found"})
      client -> json_resp(conn, 200, client)
    end
  end

  def create(conn, params) do
    case Authex.create_client(params) do
      {:ok, client} -> json_resp(conn, 200, client)
      {:error, _changeset} -> json_resp(conn, 403, %{"error" => "invalid data"})
    end
  end

  def update(conn, client_id, params) do
    case Authex.get_client(client_id) do
      nil -> json_resp(conn, 404, %{"error" => "not found"})
      client ->
        case Authex.update_client(client, params) do
          {:ok, client} -> json_resp(conn, 200, client)
          _ -> json_resp(conn, 403, %{"error" => "invalid data"})
        end
    end
  end

  def delete(conn, client_id) do
    case Authex.get_client(client_id) do
      nil -> json_resp(conn, 404, %{"error" => "not found"})
      client ->
        case Authex.delete_client(client) do
          {:ok, client} -> json_resp(conn, 200, client)
          _ -> json_resp(conn, 403, %{"error" => "invalid data"})
        end
    end
  end
end
