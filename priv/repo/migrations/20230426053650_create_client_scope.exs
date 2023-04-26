defmodule Authex.Repo.Migrations.CreateClientScope do
  use Ecto.Migration

  def change do
    create table("client_scopes", primary_key: false) do
      add :id, :uuid, primary_key: true
      add :client_id, references("clients", type: :binary_id)
      add :scope_id, references("scopes", type: :binary_id)

      timestamps(updated_at: false, type: :utc_datetime)
    end
  end
end
