defmodule AuthexWeb.Actions.Ping do
  use Web.Action

  @impl true
  def run(conn, _opts) do
    json_resp(conn, 200, %{"message" => "pong"})
  end
end
