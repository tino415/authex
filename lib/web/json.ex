defmodule Web.Json do
  import Plug.Conn

  def json_resp(conn, status, map) do
    conn
    |> put_resp_content_type("application/json;charset=utf-8")
    |> send_resp(status, Jason.encode!(map))
  end
end
