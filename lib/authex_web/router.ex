defmodule AuthexWeb.Router do
  use Web.Router

  alias AuthexWeb.Actions
  alias AuthexWeb.Routers

  plug(:match)
  plug(:dispatch)

  get "/ping", do: Actions.Ping.call(conn, nil)

  post "/tokens", to: Actions.Token.Create

  forward "", to: Routers.Protected
end
