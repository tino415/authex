defmodule Authex.Schemas.Client do
  use Domain.Schema

  alias Authex.Schemas

  import Ecto.Query

  @derive {Jason.Encoder, only: [:id, :name, :secret, :scopes]}
  schema "clients" do
    field :secret, :string, virtual: true
    field :secret_hash, :string
    field :name, :string

    has_many :scopes, Schemas.ClientScope

    timestamps(type: :utc_datetime)
  end

  def changeset(schema_or_changeset, params) do
    schema_or_changeset
    |> cast(params, [:name])
    |> generate_secret(:secret)
    |> put_hashed(:secret, :secret_hash)
    |> validate_required([:secret_hash, :name])
    |> cast_assoc(:scopes, with: &Schemas.ClientScope.changeset/2)
  end

  def secret_valid?(client, secret) do
    Crypto.hash(secret) == client.secret_hash    
  end

  def query do
    from(
      clients in __MODULE__,
      preload: [scopes: :scope]
    )
  end
end
