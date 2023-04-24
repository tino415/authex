defmodule AuthexWeb.Plugs.BasicClientAuthorization do
  use Web.Plug

  alias Plug.BasicAuth

  def init(opts), do: opts

  def call(conn, _opts) do
    case BasicAuth.parse_basic_auth(conn) do
      {id, secret} ->
        case Authex.get_client(id) do
          nil ->
            invalid_authorization(conn)
          client ->
            if Authex.client_secret_valid?(client, secret) do
              assign(conn, :current_client, client)
            else
              invalid_authorization(conn)
            end
        end
      _ ->
        conn
        |> BasicAuth.request_basic_auth()
        |> halt()
    end
    |> IO.inspect(label: "#{inspect(__MODULE__)}")
  end

  defp invalid_authorization(conn) do
    conn
    |> send_resp(403, "{\"error\": \"invalid\"}")
    |> halt()
  end
end
