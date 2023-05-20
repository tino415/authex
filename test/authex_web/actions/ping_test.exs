defmodule AuthexWeb.Actions.PingTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias AuthexWeb.Actions.Ping

  setup do
    {:ok, conn: conn("GET", "/ping")}
  end

  test "returns pong", %{conn: conn} do
    conn = Ping.run(conn)
    assert ~s({"message":"pong"}) == conn.resp_body
  end
end
