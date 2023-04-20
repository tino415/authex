defmodule AuthexWeb.Router do
  use Web.Router

  alias AuthexWeb.Controllers

  plug(:match)
  plug(:dispatch)

  get "/ping" do
    Controllers.Ping.ping(conn)
  end

  post "/users" do
    Controllers.User.create(conn)
  end

  get "/users/:user_id" do
    Controllers.User.get(conn)
  end

  match _ do
    Controllers.Fallback.not_found(conn)
  end
end
