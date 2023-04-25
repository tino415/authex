defmodule Authex.Repo.Migrations.CreateTokenScopes do
  use Ecto.Migration

  def change do
    create table("token_scopes", primary_key: false) do
      add :id, :uuid, primary_key: true
      add :token_id, references("tokens", type: :binary_id)
      add :scope_id, references("scopes", type: :binary_id)

      timestamps(type: :utc_datetime)
    end
  end
end
