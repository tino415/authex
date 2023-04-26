defmodule AuthexWeb.Actions.Scope.List do
  use AuthexWeb.Meta.Action.List do
    plug AuthexWeb.Plugs.VerifyScopes, ["oauth:scope:read"]
  end


  @impl true
  def list(conn, query_params) do
    case Pagination.cast_pagination(query_params) do
      {:ok, pagination} -> View.success(conn, Authex.list_scopes(pagination))
      {:error, changeset} -> View.invalid_request(conn, changeset)
    end
  end
end
