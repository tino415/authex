defmodule AuthexWeb.Actions.Ping do
  use Web.Action

  @impl true
  def run(conn) do
    View.success(conn, %{"message" => "pong"})
  end
end
