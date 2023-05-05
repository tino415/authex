defmodule Authex.Repo.Migrations.InsertFlowScopes do
  use Ecto.Migration

  def up do
    execute("""
    INSERT INTO scopes (id, name, build_in, inserted_at, updated_at) VALUES
    ('D11A267D-3870-481E-BBCB-313C889B490A', 'oauth:flow', true, NOW(), NOW())
    """)

  end

  def down do
    execute("""
    DELETE FROM scopes WHERE id = 'D11A267D-3870-481E-BBCB-313C889B490A'
    """)
  end
end
