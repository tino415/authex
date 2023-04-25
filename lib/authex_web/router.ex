defmodule AuthexWeb.Router do
  use Web.Router

  get "/ping", do: Actions.Ping.call(conn, nil)

  post "/tokens", to: Actions.Token.Create

  forward "", to: Routers.Protected
end
