defmodule AuthexWeb.View do
  import Web.Json

  def created(conn, body) do
    json_resp(conn, 201, body)
  end

  def success(conn, body) do
    json_resp(conn, 200, body)
  end

  def unauthorized(conn) do
    json_resp(conn, 403, %{"message" => "Missing or insufficient authorization"})
  end

  def not_found(conn) do
    json_resp(conn, 404, %{"error" => "not found"})
  end

  def invalid_request(conn) do
    json_resp(conn, 400, %{"error" => "invalid request"})
  end

  def internal_server_error(conn) do
    json_resp(conn, 500, %{"message" => "internal server error"})
  end
end
