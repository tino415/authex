defmodule AuthexWeb.Actions.Flow.Submit do
  use AuthexWeb.Meta.Action.Get, name: "flow_id"

  @impl true
  def get(conn, flow_id) do
    with %{} = flow <- Authex.get_flow(flow_id),
         {:ok, flow} <- Authex.submit_flow(flow) do
      query_params = %{"code" => flow.code}

      # TODO: state handling
      # query_params =
      # if flow.state do
      # Map.put(query_params, "state", flow.state)
      # else
      # query_params
      # end

      url = URI.parse(flow.redirect_uri)
      url = %{url | query: URI.encode_query(query_params)}
      url = URI.to_string(url)

      View.redirect(conn, url)
    else
      nil -> View.not_found(conn)
      {:error, changeset} -> View.invalid_request(conn, changeset)
    end
  end
end
