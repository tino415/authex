defmodule AuthexWeb.Actions.Flow.Create do
  use AuthexWeb.Meta.Action.List

  @impl true
  def list(conn, query_params) do
    with {:ok, flow} <- Authex.create_flow(query_params) do
      url = URI.parse(flow.client.authorization_url)
      url = %{url | query: URI.encode_query(%{"flow_id" => flow.id})}
      url = URI.to_string(url)

      View.redirect(conn, url)
    end
  end
end
