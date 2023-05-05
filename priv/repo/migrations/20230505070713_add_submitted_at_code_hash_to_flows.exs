defmodule Authex.Repo.Migrations.AddSubmittedAtCodeHashToFlows do
  use Ecto.Migration

  def change do
    alter table("flows") do
      add :user_id, references("users", type: :uuid)
      add :submitted_at, :utc_datetime
      add :code_hash, :binary
    end
  end
end
