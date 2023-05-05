defmodule Authex.Repo.Migrations.CreateFlow do
  use Ecto.Migration

  def change do
    create table("flows", primary_key: false) do
      add :id, :uuid, primary_key: true
      add :client_id, references("clients", type: :binary_id)
      add :token_id, references("tokens", type: :binary_id)
      add :grant_type, :string
      add :redirect_uri, :string

      timestamps(type: :utc_datetime)
    end
  end
end
