defmodule AuthexWeb.Actions.User.List do
  use AuthexWeb.Meta.Action.List do
    plug AuthexWeb.Plugs.VerifyScopes, ["oauth:user:read"]
  end

  @impl true
  def list(conn, query_params) do
    case Pagination.cast_pagination(query_params) do
      {:ok, pagination} -> View.success(conn, Authex.list_users(pagination))
      {:error, changeset} -> View.invalid_request(conn, changeset)
    end
  end
end
