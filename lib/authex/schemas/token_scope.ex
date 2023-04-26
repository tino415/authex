defmodule Authex.Schemas.TokenScope do
  use Domain.Schema

  alias Authex.Schemas

  schema "token_scopes" do
    belongs_to :token, Schemas.Token
    belongs_to :scope, Schemas.Scope

    timestamps(updated_at: false, type: :utc_datetime)
  end

  def changeset(changeset_or_struct, scope) do
    changeset_or_struct
    |> change()
    |> put_assoc(:scope, scope)
  end
end
