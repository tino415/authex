defmodule Authex.Repo.Migrations.AddGrantTypeToTokens do
  use Ecto.Migration

  def change do
    alter table("tokens", primary_key: false) do
      add :grant_type, :string, null: false, default: "client_credentials"
    end
  end
end
