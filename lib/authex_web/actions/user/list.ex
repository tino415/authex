defmodule AuthexWeb.Actions.User.List do
  use Web.Action.List

  @impl true
  def list(conn, query_params) do
    case Pagination.cast_pagination(query_params) do
      {:ok, pagination} -> View.success(conn, Authex.list_users(pagination))
      {:error, changeset} -> View.invalid_request(conn, changeset)
    end
  end
end
