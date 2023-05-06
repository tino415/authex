defmodule Authex.Repo.Migrations.RenameGrantTypeToResponseInFlows do
  use Ecto.Migration

  def up do
    alter table("flows") do
      add :response, :string
    end

    execute("UPDATE flows SET response = grant_type")

    alter table("flows") do
      remove :grant_type
    end
  end

  def down do
    alter table("flows") do
      add :grant_type, :string
    end

    execute("UPDATE flows SET grant_type = response")

    alter table("flows") do
      remove :response
    end
  end
end
