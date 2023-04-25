defmodule AuthexWeb.Actions.Scope.Create do
  use Web.Action

  def run(conn, _opts) do
    case Authex.create_scope(conn.body_params) do
      {:ok, scope} -> json_resp(conn, 201, scope)
      {:error, _} -> json_resp(conn, 422, %{"message" => "invalid_request"})
    end
  end
end
