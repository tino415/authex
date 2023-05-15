defmodule AuthexWeb.Middleware do
  import Plug.Conn

  def current_client(conn) do
    conn.assigns.current_client
  end

  def assign_current_client(conn, client) do
    assign(conn, :current_client, client)
  end

  def current_scope(conn) do
    Map.get(conn.assigns.current_claims || %{}, "scope", "") || ""
  end

  def assign_current_claims(conn, claims) do
    assign(conn, :current_claims, claims)
  end
end
