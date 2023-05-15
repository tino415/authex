defmodule Authex.Schemas.Scope do
  use Domain.Meta.Schema

  @derive {Jason.Encoder, only: [:id, :name]}
  schema "scopes" do
    field(:name, :string)
    field(:build_in, :boolean, default: false)
    field(:grant_type, Ecto.Enum,
      values: [
        :client_credentials,
        :authorization_code
      ])

    has_many(:scope_clients, Schemas.ClientScope)

    timestamps(type: :utc_datetime)
  end

  def changeset(schema_or_changeset, parameters) do
    schema_or_changeset
    |> cast(parameters, [:name, :grant_type])
    |> validate_required([:name, :grant_type])
  end

  def for_client_query(client_id, grant_type, scopes) do
    from(
      s in __MODULE__,
      inner_join: sc in assoc(s, :scope_clients),
      where: s.name in ^scopes,
      where: sc.client_id == ^client_id,
      where: s.grant_type == ^grant_type
    )
  end
end
