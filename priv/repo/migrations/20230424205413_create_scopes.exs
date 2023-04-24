defmodule Authex.Repo.Migrations.CreateScopes do
  use Ecto.Migration

  def change do
    create table("scopes", primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :build_in, :boolean

      timestamps()
    end
  end
end
