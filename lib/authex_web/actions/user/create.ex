defmodule AuthexWeb.Actions.User.Create do
  use Web.Action.Create do
    plug AuthexWeb.Plugs.VerifyScopes, ["oauth:user:create"]
  end

  @impl true
  def create(conn, body_params) do
    case Authex.create_user(body_params) do
      {:ok, user} -> View.created(conn, user)
      {:error, changeset} -> View.invalid_request(conn, changeset)
    end
  end
end
