defmodule AuthexWeb.Controllers.Token do
  use Web.Controller

  def create(conn, client, %{}) do
    case Authex.create_token(client) do
      {:ok, token} -> json_resp(conn, 201, token)
      {:error, _changeset} -> json_resp(conn, 403, %{"error" => "invalid data"})
    end
  end
end
