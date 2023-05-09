defmodule AuthexWeb.Plugs.AccessTokenAuthentication do
  use AuthexWeb.Meta.Plug

  require Logger

  def init(opts), do: opts

  def call(conn, _opts) do
    IO.puts("auth")

    case get_req_header(conn, "authorization") do
      ["Bearer " <> access_token] ->
        case Joken.verify_and_validate(%{}, access_token) do
          {:ok, %{"aud" => client_id} = claims} ->
            case Authex.get_client(client_id) do
              nil ->
                Logger.info("unknown client")
                send_unauthorized(conn)

              client ->
                conn
                |> assign_current_client(client)
                |> assign_current_claims(claims)
            end

          {:error, _} ->
            Logger.info("invalid access token")
            send_unauthorized(conn)
        end

      _ ->
        Logger.info("missing access token")
        send_unauthorized(conn)
    end
  end

  defp send_unauthorized(conn) do
    conn
    |> View.unauthorized()
    |> halt()
  end
end
