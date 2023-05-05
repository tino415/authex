defmodule Authex.Repo.Migrations.AddAuthorizationUrlToClients do
  use Ecto.Migration

  def change do
    alter table("clients") do
      add :authorization_url, :string
    end
  end
end
