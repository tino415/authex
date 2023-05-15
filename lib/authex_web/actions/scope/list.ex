defmodule AuthexWeb.Actions.Scope.List do
  use AuthexWeb.Meta.Action.List do
    plug(AuthexWeb.Plugs.VerifyScopes, ["oauth:scope:read"])
  end

  @impl true
  def list(conn, query_params) do
    with {:ok, pagination} <- Pagination.cast_pagination(query_params) do
      View.success(conn, Authex.list_scopes(pagination))
    end
  end
end
