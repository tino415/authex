defmodule AuthexWeb.Actions.Flow.Update do
  use AuthexWeb.Meta.Action.Update, [name: "flow_id", do: (
    plug AuthexWeb.Plugs.VerifyScopes, ["oauth:flow"]
  )]

  @impl true
  def update(conn, flow_id, params) do
    with %{} = flow <- Authex.get_flow(flow_id),
         {:ok, flow} <- Authex.update_flow(flow, params) do
      View.success(conn, flow)
    else
      nil -> View.not_found(conn)
      {:error, changeset} -> View.invalid_request(conn, changeset)
    end
  end
end
