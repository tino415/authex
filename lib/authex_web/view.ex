defmodule AuthexWeb.View do
  import PlugJason
  import Plug.Conn

  def created(conn, body) do
    json_created(conn, body)
  end

  def success(conn, body) do
    json_success(conn, body)
  end

  def unauthorized(conn) do
    json_unauthorized(conn, %{"message" => "Missing or insufficient authorization"})
  end

  def not_found(conn) do
    json_not_found(conn, %{"error" => "not found"})
  end

  def invalid_request_changeset(conn, changeset) do
    json_unprocessable_entity_changeset(conn, changeset)
  end

  def invalid_request(conn, error) do
    json_unprocessable_entity(conn, error)
  end

  def internal_server_error(conn) do
    json_ise(conn, %{"message" => "internal server error"})
  end

  def redirect(conn, url) do
    conn
    |> put_resp_header("location", url)
    |> send_resp(302, "Redirecting to #{url}")
  end
end
