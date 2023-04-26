defmodule AuthexWeb.Actions.Ping do
  use AuthexWeb.Meta.Action

  @impl true
  def run(conn) do
    View.success(conn, %{"message" => "pong"})
  end
end
