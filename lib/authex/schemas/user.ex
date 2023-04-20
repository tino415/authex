defmodule Authex.Schemas.User do
  use Domain.Schema

  @derive {Jason.Encoder, only: [:id, :email]}
  schema "users" do
    field(:email, :string)
    field(:password, :string, virtual: true)
    field(:password_verify, :string, virtual: true)
    field(:password_hash, :string)

    timestamps()
  end

  def changeset(user, params) do
    user
    |> cast(params, [:email, :password, :password_verify])
    |> put_hashed(:password, :password_hash)
    |> validate()
  end

  defp validate(changeset) do
    changeset
    |> validate_fields_equal(:password, :password_verify)
    |> validate_required([:email, :password_hash])
  end
end
