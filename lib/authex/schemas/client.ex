defmodule Authex.Schemas.Client do
  use Domain.Meta.Schema

  @derive {Jason.Encoder, only: [:id, :name, :secret, :scopes, :authorization_url]}
  schema "clients" do
    field(:secret, :string, virtual: true)
    field(:secret_hash, :string)
    field(:name, :string)
    field(:authorization_url, Types.URI)

    has_many(:scopes, Schemas.ClientScope, on_replace: :delete)

    timestamps(type: :utc_datetime)
  end

  def changeset(schema_or_changeset, params) do
    schema_or_changeset
    |> cast(params, [:name, :authorization_url])
    |> generate_secret(:secret)
    |> put_hashed(:secret, :secret_hash)
    # TODO: if authorization_code alloweed, authorization_url is required
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

  def get(client_id) do
    from(
      clients in __MODULE__,
      preload: [scopes: :scope],
      where: clients.id == ^client_id
    )
  end
end
