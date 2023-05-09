defmodule Authex.Schemas.User do
  use Domain.Meta.Schema

  @derive {Jason.Encoder, only: [:id, :email]}
  schema "users" do
    field(:email, :string)
    field(:password, :string, virtual: true)
    field(:password_verify, :string, virtual: true)
    field(:password_hash, :string)

    timestamps(type: :utc_datetime)
  end

  def changeset(user, params) do
    user
    |> cast(params, [:email, :password, :password_verify])
    |> put_hashed(:password, :password_hash)
    |> validate()
  end

  def password_valid?(user, password) do
    Crypto.hash(password) == user.password_hash
  end

  def query_by_username(username) do
    from(
      u in __MODULE__,
      where: u.email == ^username
    )
  end

  defp validate(changeset) do
    changeset
    |> validate_fields_equal(:password, :password_verify)
    |> validate_required([:email, :password_hash])
  end
end
