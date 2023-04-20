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

  def delete_user(user_id) do
    Repo.delete(Schemas.User, user_id)
  end

  def update_user(user, params) do
    user
    |> Schemas.User.changeset(params)
    |> Repo.update()
  end
end
