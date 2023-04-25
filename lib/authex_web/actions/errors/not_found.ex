defmodule AuthexWeb.Actions.Errors.NotFound do
  use Web.Action

  @impl true
  def run(conn, _opts) do
    json_resp(conn, 404, %{"error" => "not found"})
  end
end
