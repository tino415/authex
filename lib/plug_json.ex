defmodule PlugJason do
  import Plug.Conn, only: [send_resp: 3, put_resp_content_type: 2]
  import Jason, only: [encode!: 1]
  import Ecto.Changeset, only: [traverse_errors: 2]

  def json_created(conn, body) do
    json_resp(conn, 201, body)
  end

  def json_success(conn, body) do
    json_resp(conn, 200, body)
  end

  def json_unauthorized(conn, body) do
    json_resp(conn, 403, body)
  end

  def json_not_found(conn, body) do
    json_resp(conn, 404, body)
  end

  def json_ise(conn, body) do
    json_resp(conn, 500, body)
  end

  def json_unprocessable_entity_changeset(conn, changeset) do
    json_resp(conn, 422, changeset_to_map(changeset))
  end

  defp changeset_to_map(changeset) do
    traverse_errors(changeset, fn {msg, opts} ->
      Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
        opts
        |> Keyword.get(String.to_existing_atom(key), key)
        |> to_string()
      end)
    end)
  end

  defp json_resp(conn, status, map) do
    conn
    |> put_resp_content_type("application/json;charset=utf-8")
    |> send_resp(status, encode!(map))
  end
end
