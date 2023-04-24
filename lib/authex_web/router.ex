defmodule AuthexWeb.Router do
  use Web.Router

  alias AuthexWeb.Controllers
  alias AuthexWeb.Routers

  plug(:match)
  plug(:dispatch)

  get "/ping", do: Controllers.Ping.ping(conn)

  forward "/tokens", to: Routers.Token

  forward "", to: Routers.Protected
end
