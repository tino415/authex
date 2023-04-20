defmodule Authex do
  alias Authex.Schemas
  alias Authex.Repo

  def create_user(params) do
    %Schemas.User{}
    |> Schemas.User.changeset(params)
    |> Repo.insert()
  end

  def get_user(user_id) do
    Repo.get(Schemas.User, user_id)
  end
end
