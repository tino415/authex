defmodule AuthexWeb.Router do
  use Web.Router

  alias AuthexWeb.Controllers

  plug(:match)
  plug(:dispatch)

  get "/ping" do
    Controllers.Ping.ping(conn)
  end

  get "/users" do
    Controllers.User.list(conn, conn.query_params)
  end

  get "/users/:user_id" do
    Controllers.User.get(conn, conn.path_params)
  end

  post "/users" do
    Controllers.User.create(conn, conn.body_params)
  end


  put "/users/:user_id" do
    Controllers.User.update(conn, conn.path_params["user_id"], conn.body_params)
  end

  delete "/users/:user_id" do
    Controllers.User.delete(conn, conn.path_params["user_id"])
  end

  match _ do
    Controllers.Fallback.not_found(conn)
  end
end
