defmodule AuthexWeb.Plugs.BasicClientAuthentication do
  use AuthexWeb.Meta.Plug

  alias Plug.BasicAuth

  require Logger

  def init(opts), do: opts

  def call(conn, _opts) do
    case BasicAuth.parse_basic_auth(conn) do
      {id, secret} ->
        case Authex.get_client(id) do
          nil ->
            Logger.info("unknown client")
            invalid_authorization(conn)

          client ->
            if Authex.client_secret_valid?(client, secret) do
              Logger.info("verified client")
              assign_current_client(conn, client)
            else
              Logger.info("invalid secret")
              invalid_authorization(conn)
            end
        end

      _ ->
        Logger.info("missing authorization")
        request_basic_auth(conn)
    end
  end

  defp invalid_authorization(conn) do
    conn
    |> View.unauthorized()
    |> halt()
  end

  defp request_basic_auth(conn) do
    conn
    |> BasicAuth.request_basic_auth()
    |> halt()
  end
end
