defmodule AuthexWeb.Actions.Token.Create do
  use AuthexWeb.Meta.Action.Create do
    plug(AuthexWeb.Plugs.BasicClientAuthentication)
  end

  @impl true
  def create(conn, %{"code" => code} = params) do
    with %{} = flow <- Authex.get_flow_by_code_without_token(code) do
      do_create(conn, flow, params)
    else
      nil -> View.unauthorized(conn)
    end
  end

  def create(conn, %{"refresh_token" => refresh_token} = params) do
    with %{} = flow <- Authex.get_flow_by_refresh_token(refresh_token) do
      do_create(conn, flow, params)
    else
      nil -> View.unauthorized(conn)
    end
  end

  def create(conn, body_params) do
    do_create(conn, nil, body_params)
  end

  defp do_create(conn, flow, body_params) do
    with {:ok, token} <- Authex.create_token(conn.assigns.current_client, flow, body_params) do
      View.created(conn, token)
    end
  end
end
