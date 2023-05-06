defmodule AuthexWeb.Actions.Token.Create do
  use AuthexWeb.Meta.Action.Create do
    plug(AuthexWeb.Plugs.BasicClientAuthentication)
  end

  @impl true
  def create(conn, %{"code" => code} = params) do
    with %{} = flow <- Authex.get_flow_by_code(code) do
      do_create(conn, flow, params)
    else
      nil -> View.unauthorized(conn)
    end
  end

  # TODO: resolve refresh tokens

  def create(conn, body_params) do
    do_create(conn, nil, body_params)
  end

  defp do_create(conn, flow, body_params) do
    case Authex.create_token(conn.assigns.current_client, flow, body_params) do
      {:ok, token} -> View.created(conn, token)
      {:error, changeset} -> View.invalid_request(conn, changeset)
    end
  end
end
