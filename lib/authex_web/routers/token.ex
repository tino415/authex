defmodule AuthexWeb.Routers.Token do
  use Web.Router

  alias AuthexWeb.Plugs
  alias AuthexWeb.Controllers

  plug(Plugs.BasicClientAuthorization)
  plug(:match)
  plug(:dispatch)

  post "/" do
    IO.inspect(conn.assigns, label: "currents")
    Controllers.Token.create(conn, conn.assigns.current_client, conn.body_params)
  end

  match _ do
    Controllers.Fallback.not_found(conn)
  end
end
