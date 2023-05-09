defmodule Authex.Schemas.ClientScope do
  use Domain.Meta.Schema

  @derive {Jason.Encoder, only: [:scope]}
  schema "client_scopes" do
    belongs_to(:client, Schemas.Client)
    belongs_to(:scope, Schemas.Scope)

    timestamps(updated_at: false, type: :utc_datetime)
  end

  def changeset(changeset_or_struct, params) do
    changeset_or_struct
    |> cast(params, [:client_id, :scope_id])
  end
end
