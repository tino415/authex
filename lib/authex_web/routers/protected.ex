defmodule AuthexWeb.Routers.Protected do
  use Web.Router

  alias AuthexWeb.Controllers
  alias AuthexWeb.Plugs

  plug(Plugs.AccessTokenAuthentication)
  plug(:match)
  plug(:dispatch)

  get "/users" do
    Controllers.User.list(conn, conn.query_params)
  end

  get "/users/:user_id" do
    Controllers.User.get(conn, conn.path_params["user_id"])
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

  get "/clients" do
    Controllers.Client.list(conn, conn.query_params)
  end

  get "/clients/:client_id" do
    Controllers.Client.get(conn, conn.path_params["client_id"])
  end

  post "/clients" do
    Controllers.Client.create(conn, conn.body_params)
  end

  put "/clients/:client_id" do
    Controllers.Client.update(conn, conn.path_params["client_id"], conn.body_params)
  end

  delete "/clients/:client_id" do
    Controllers.Client.delete(conn, conn.path_params["client_id"])
  end

  get "/scopes" do
    Controllers.Scope.list(conn, conn.query_params)
  end

  get "/scopes/:scope_id" do
    Controllers.Scope.get(conn, conn.params["scope_id"])
  end

  post "/scopes" do
    Controllers.Scope.create(conn, conn.body_params)
  end

  put "/scopes/:scope_id" do
    Controllers.Scope.update(conn, conn.params["scope_id"], conn.body_params)
  end

  delete "/scopes/:scope_id" do
    Controllers.Scope.delete(conn, conn.params["scope_id"])
  end

  match _ do
    Controllers.Fallback.not_found(conn)
  end
end
