defmodule AuthexWeb.Middlewares.VerifyScopes do
  use AuthexWeb.Meta.Middleware

  require Logger

  def init(required_scopes), do: required_scopes

  def call(conn, required_scopes) do
    provided_scopes = current_scope(conn)
    provided_scopes = String.split(provided_scopes, " ")

    if Enum.any?(provided_scopes, &(&1 in required_scopes)) do
      Logger.info("scopes verifier")
      conn
    else
      Logger.info("invalid scopes #{inspect(provided_scopes)} to #{inspect(required_scopes)}")

      conn
      |> View.unauthorized()
      |> halt()
    end
  end
end
