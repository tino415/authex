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
    from(c in Schemas.Client, order_by: [desc: c.inserted_at])
    |> Pagination.paginate(Repo, pagination)
  end

  def get_client(client_id) do
    Repo.get(Schemas.Client, client_id)
  end

  def create_client(params) do
    %Schemas.Client{}
    |> Schemas.Client.changeset(params)
    |> Repo.insert()
  end

  def delete_client(client) do
    Repo.delete(client)
  end

  def update_client(client, params) do
    client
    |> Schemas.Client.changeset(params)
    |> Repo.update()
  end

  def client_secret_valid?(client, secret) do
    Schemas.Client.secret_valid?(client, secret)
  end

  def create_token(client) do
    %Schemas.Token{}
    |> Schemas.Token.changeset(client)
    |> Repo.insert()
  end
end
