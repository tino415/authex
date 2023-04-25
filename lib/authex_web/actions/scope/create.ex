defmodule AuthexWeb.Actions.Scope.Create do
  use Web.Action.Create

  @impl true
  def create(conn, body_params) do
    case Authex.create_scope(body_params) do
      {:ok, scope} -> View.created(conn, scope)
      {:error, _} -> View.invalid_request(conn)
    end
  end
end
