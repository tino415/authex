defmodule Authex.Schemas.Scope do
  use Domain.Schema

  import Ecto.Query

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

  def query(scopes) do
    from(
      s in __MODULE__,
      where: s.name in ^scopes
    )
  end
end
