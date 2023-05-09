defmodule Authex.Repo.Migrations.AddAuthorizationCodeAlloweedToClients do
  use Ecto.Migration

  def change do
    alter table("clients") do
      add :authorization_code_alloweed, :boolean, default: false
    end
  end
end
