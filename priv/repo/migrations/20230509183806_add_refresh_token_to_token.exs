defmodule Authex.Repo.Migrations.AddRefreshTokenToToken do
  use Ecto.Migration

  def change do
    alter table("tokens") do
      add :refresh_token, :binary
    end
  end
end
