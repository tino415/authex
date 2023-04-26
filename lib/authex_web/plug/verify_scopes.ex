defmodule AuthexWeb.Plugs.VerifyScopes do
  use AuthexWeb.Meta.Plug

  def init(required_scopes), do: required_scopes

  def call(conn, required_scopes) do
    provided_scopes = current_scope(conn)
    provided_scopes = String.split(provided_scopes, " ")

    if Enum.any?(provided_scopes, &(&1 in required_scopes)) do
      conn
    else
      conn
      |> View.unauthorized()
      |> halt()
    end
  end
end
