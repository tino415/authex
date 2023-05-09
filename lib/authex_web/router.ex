defmodule AuthexWeb.Router do
  use AuthexWeb.Meta.Router

  get("/ping", do: Actions.Ping.call(conn, nil))

  post("/tokens", to: Actions.Token.Create)

  # TODO rename to authorization or grant
  get("/flows", to: Actions.Flow.Create)

  get("/flows/:flow_id/submit", to: Actions.Flow.Submit)

  forward("", to: Routers.Protected)
end
