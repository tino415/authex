defmodule AuthexWeb.Routers.Protected do
  use AuthexWeb.Meta.Router do
    plug(Middlewares.AccessTokenAuthentication)
  end

  get("/users", to: Actions.User.List)

  get("/users/:user_id", to: Actions.User.Get)

  post("/users", to: Actions.User.Create)

  put("/users/:user_id", to: Actions.User.Update)

  delete("/users/:user_id", to: Actions.User.Delete)

  get("/clients", to: Actions.Client.List)

  get("/clients/:client_id", to: Actions.Client.Get)

  post("/clients", to: Actions.Client.Create)

  put("/clients/:client_id", to: Actions.Client.Update)

  delete("/clients/:client_id", to: Actions.Client.Delete)

  get("/scopes", to: Actions.Scope.List)

  get("/scopes/:scope_id", to: Actions.Scope.Get)

  post("/scopes", to: Actions.Scope.Create)

  put("/scopes/:scope_id", to: Actions.Scope.Update)

  delete("/scopes/:scope_id", to: Actions.Scope.Delete)

  put("/flows/:flow_id", to: Actions.Flow.Update)

  match(_, to: Actions.Errors.NotFound)
end
