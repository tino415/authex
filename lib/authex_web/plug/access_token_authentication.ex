defmodule AuthexWeb.Plugs.AccessTokenAuthentication do
  use Web.Plug

  def init(opts), do: opts

  def call(conn, _opts) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> access_token] ->
        case Joken.verify_and_validate(%{}, access_token) |> IO.inspect(label: "joken response") do
          {:ok, %{"aud" => client_id} = claims} ->
            case Authex.get_client(client_id) do
              nil -> send_unauthorized(conn)
              client ->
                conn
                |> assign(:current_client, client)
                |> assign(:current_claims, claims)
            end
          {:error, _} -> send_unauthorized(conn)
        end
      _ -> send_unauthorized(conn)
    end
  end

  defp send_unauthorized(conn) do
    conn
    |> json_resp(403, %{"message" => "Missing or insufficient authorization"})
    |> halt()
  end
end
