defmodule Authex.Repo.Migrations.CreateClients do
  use Ecto.Migration

  def change do
    create table("clients", primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :secret_hash, :binary

      timestamps()
    end
  end
end
