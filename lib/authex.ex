defmodule Authex do
  alias Authex.Schemas
  alias Authex.Repo

  import Ecto.Query

  def list_users(pagination) do
    from(u in Schemas.User, order_by: [desc: u.inserted_at])
    |> Pagination.paginate(Repo, pagination)
  end

  def get_user(user_id) do
    Repo.get(Schemas.User, user_id)
  end

  def create_user(params) do
    %Schemas.User{}
    |> Schemas.User.changeset(params)
    |> Repo.insert()
  end

  def delete_user(user) do
    Repo.delete(user)
  end

  def update_user(user, params) do
    user
    |> Schemas.User.changeset(params)
    |> Repo.update()
  end

  def list_clients(pagination) do
    Schemas.Client.query()
    |> order_by(desc: :inserted_at)
    |> Pagination.paginate(Repo, pagination)
  end

  def get_client(client_id) do
    Repo.get(Schemas.Client.query(), client_id)
  end

  def create_client(params) do
    %Schemas.Client{}
    |> Schemas.Client.changeset(params)
    |> Repo.insert()
    |> case do
       {:ok, client} -> {:ok, Repo.preload(client, :scopes)}
       r -> r
    end
  end

  def delete_client!(client) do
    Repo.delete!(client)
  end

  def update_client(client, params) do
    client
    |> Schemas.Client.changeset(params)
    |> Repo.update()
    # TODO: debug this, should be loaded if using cast assoc
    |> case do
         {:ok, client} -> {:ok, Repo.preload(client, scopes: :scope)}
         r -> r
     end
  end

  def client_secret_valid?(client, secret) do
    Schemas.Client.secret_valid?(client, secret)
  end

  def create_token(client, flow, body_params) do
    %Schemas.Token{}
    |> Schemas.Token.changeset(client, flow, body_params)
    |> Repo.insert()
    # TODO: debug this, should be loaded if using cast assoc
    |> case do
         {:ok, token} -> {:ok, Schemas.Token.generate_access_token(token)}
         error -> error
     end
  end

  def list_scopes(pagination) do
    from(s in Schemas.Scope, order_by: [desc: s.inserted_at])
    |> Pagination.paginate(Repo, pagination)
  end

  def get_scope(scope_id) do
    Repo.get(Schemas.Scope, scope_id)
  end

  def create_scope(parameters) do
    %Schemas.Scope{}
    |> Schemas.Scope.changeset(parameters)
    |> Repo.insert()
  end

  def delete_scope(scope) do
    if scope.build_in do
      {:error, :build_in}
    else
      Repo.delete(scope)
    end
  end

  def update_scope(scope, parameteres) do
    scope
    |> Schemas.Scope.changeset(parameteres)
    |> Repo.update()
  end

  def get_flow(flow_id) do
    Schemas.Flow
    |> Repo.get(flow_id)
    |> Repo.preload(:user)
  end

  def get_flow_by_code(code) do
    code
    |> Schemas.Flow.query_by_code()
    |> Repo.one()
  end

  def create_flow(parameters) do
    %Schemas.Flow{}
    |> Schemas.Flow.changeset(parameters)
    |> Repo.insert()
    |> case do
       {:ok, flow} -> {:ok, Repo.preload(flow, :client)}
       r -> r
    end
  end

  def update_flow(flow, parameters) do
    flow
    |> Schemas.Flow.changeset(parameters)
    |> Repo.update()
    |> case do
         {:ok, flow} -> {:ok, Repo.preload(flow, :client)}
         r -> r
    end
  end

  def submit_flow(flow) do
    flow
    |> Schemas.Flow.submit_changeset()
    |> Repo.update()
    |> case do
       {:ok, flow} -> {:ok, Repo.preload(flow, :client)}
       r -> r
    end
  end
end
