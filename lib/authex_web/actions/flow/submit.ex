defmodule AuthexWeb.Actions.Flow.Submit do
  use AuthexWeb.Meta.Action.Get, name: "flow_id"

  @impl true
  def get(conn, flow_id) do
    with %{} = flow <- Authex.get_flow(flow_id),
         {:ok, flow} <- Authex.submit_flow(flow) do
      query_params = %{"code" => flow.code}

      # TODO: handle state

      url = %{flow.redirect_uri | query: URI.encode_query(query_params)}

      View.redirect(conn, to_string(url))
    end
  end
end
