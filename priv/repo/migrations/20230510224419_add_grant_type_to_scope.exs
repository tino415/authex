defmodule Authex.Repo.Migrations.AddGrantTypeToScope do
  use Ecto.Migration

  def change do
    alter table("scopes") do
      add :grant_type, :string, default: "client_credentials"
    end
  end
end
