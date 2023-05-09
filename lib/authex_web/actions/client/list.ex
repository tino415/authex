defmodule AuthexWeb.Actions.Client.List do
  use AuthexWeb.Meta.Action.List do
    plug(AuthexWeb.Plugs.VerifyScopes, ["oauth:client:read"])
  end

  @impl true
  def list(conn, pagination) do
    case Pagination.cast_pagination(pagination) do
      {:ok, pagination} -> View.success(conn, Authex.list_clients(pagination))
      _ -> View.not_found(conn)
    end
  end
end
