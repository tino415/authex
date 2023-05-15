defmodule AuthexWeb.Actions.Client.List do
  use AuthexWeb.Meta.Action.List do
    plug(AuthexWeb.Middlewares.VerifyScopes, ["oauth:client:read"])
  end

  @impl true
  def list(conn, pagination) do
    with {:ok, pagination} <- Pagination.cast_pagination(pagination) do
      View.success(conn, Authex.list_clients(pagination))
    end
  end
end
