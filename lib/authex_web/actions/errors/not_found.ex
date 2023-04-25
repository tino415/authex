defmodule AuthexWeb.Actions.Errors.NotFound do
  use Web.Action

  @impl true
  defdelegate run(conn), to: View, as: :not_found
end
