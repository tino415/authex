defmodule AuthexWeb.Routers.Token do
  use Web.Router

  alias AuthexWeb.Plugs
  alias AuthexWeb.Controllers

  plug(Plugs.BasicClientAuthentication)
  plug(:match)
  plug(:dispatch)

  post "/" do
    Controllers.Token.create(conn, conn.assigns.current_client, conn.body_params)
  end

  match _ do
    Controllers.Fallback.not_found(conn)
  end
end
