defmodule AuthexWeb.View do
  import Web.Json

  alias Ecto.Changeset

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

  def invalid_request(conn, changeset) do
    response = 
      Changeset.traverse_errors(changeset, fn {msg, opts} ->
        Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
          opts
          |> Keyword.get(String.to_existing_atom(key), key)
          |> to_string()
        end)
      end)

    json_resp(conn, 422, response)
  end

  def internal_server_error(conn) do
    json_resp(conn, 500, %{"message" => "internal server error"})
  end
end
