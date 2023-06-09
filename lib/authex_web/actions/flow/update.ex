defmodule AuthexWeb.Actions.Flow.Update do
  use AuthexWeb.Meta.Action.Update,
    name: "flow_id",
    do: plug(AuthexWeb.Middlewares.VerifyScopes, ["oauth:flow"])

  @impl true
  def update(conn, flow_id, params) do
    with %{} = flow <- Authex.get_flow(flow_id),
         {:ok, flow} <- Authex.update_flow(flow, params) do
      View.success(conn, flow)
    end
  end
end
