defmodule Authex.Schemas.Client do
  use Domain.Schema

  @derive {Jason.Encoder, only: [:id, :name, :secret]}
  schema "clients" do
    field :secret, :string, virtual: true
    field :secret_hash, :string
    field :name, :string
    timestamps()
  end

  def changeset(schema_or_changeset, params) do
    schema_or_changeset
    |> cast(params, [:name])
    |> generate_secret(:secret)
    |> put_hashed(:secret, :secret_hash)
    |> validate_required([:secret_hash, :name])
  end

  def secret_valid?(client, secret) do
    Crypto.hash(secret) == client.secret_hash    
  end
end
