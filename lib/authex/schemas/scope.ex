defmodule Authex.Schemas.Scope do
  use Domain.Schema

  @derive {Jason.Encoder, only: [:id, :name]}
  schema "scopes" do
    field :name, :string
    field :build_in, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  def changeset(schema_or_changeset, parameters) do
    # TODO: build in required false
    schema_or_changeset
    |> cast(parameters, [:name])
    |> validate_required([:name])
  end
end
