defmodule Authex.Repo.Migrations.CreateTokens do
  use Ecto.Migration

  def change do
    create table("tokens", primary_key: false) do
      add :id, :uuid, primary_key: true
      add :client_id, references(:clients, type: :uuid)
      add :access_token, :binary
      add :expires_in, :integer
      add :expires_at, :utc_datetime

      timestamps()
    end
  end
end
