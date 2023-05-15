defmodule AuthexWeb.Actions.User.List do
  use AuthexWeb.Meta.Action.List do
    plug(AuthexWeb.Plugs.VerifyScopes, ["oauth:user:read"])
  end

  @impl true
  def list(conn, query_params) do
    with {:ok, pagination} <- Pagination.cast_pagination(query_params) do
      View.success(conn, Authex.list_users(pagination))
    end
  end
end
