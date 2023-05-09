defmodule Authex.Schemas.Scope do
  use Domain.Meta.Schema

  @derive {Jason.Encoder, only: [:id, :name]}
  schema "scopes" do
    field(:name, :string)
    field(:build_in, :boolean, default: false)

    has_many(:scope_clients, Schemas.ClientScope)

    timestamps(type: :utc_datetime)
  end

  def changeset(schema_or_changeset, parameters) do
    # TODO: build in required false
    schema_or_changeset
    |> cast(parameters, [:name])
    |> validate_required([:name])
  end

  def for_client_query(client_id, scopes) do
    from(
      s in __MODULE__,
      inner_join: sc in assoc(s, :scope_clients),
      where: s.name in ^scopes,
      where: sc.client_id == ^client_id
    )
  end
end
