defmodule Authex.Repo.Migrations.InsertBuildInScopes do
  use Ecto.Migration

  def up do
    execute("""
    INSERT INTO scopes (id, name, build_in, inserted_at, updated_at) VALUES
    ('CEB95698-0C72-4239-8A81-C90A8B39DC73', 'oauth:client:create', true, NOW(), NOW()),
    ('0E59E5B6-83BA-43A4-B74B-989DC0FF3301', 'oauth:client:update', true, NOW(), NOW()),
    ('714999B0-7478-4346-A144-6FC7ABDB544D', 'oauth:client:delete', true, NOW(), NOW()),
    ('D60DC3C8-BCD2-456D-9170-9B792BDCC662', 'oauth:client:read', true, NOW(), NOW()),

    ('8B41469D-FFE4-4F67-A253-1728F3100E67', 'oauth:scope:create', true, NOW(), NOW()),
    ('01850852-7484-4B7B-A02D-8616CF183CA7', 'oauth:scope:update', true, NOW(), NOW()),
    ('D4804CD4-C07B-4AF0-960C-A1112D7CBEE0', 'oauth:scope:delete', true, NOW(), NOW()),
    ('8859E808-04AC-440D-83FD-B3864B8D09E1', 'oauth:scope:read', true, NOW(), NOW()),

    ('5F6B7700-E781-45B7-B3C1-B0B91CE3A1EE', 'oauth:user:create', true, NOW(), NOW()),
    ('34C6299A-307B-4379-98C2-FCB81DA9C8F4', 'oauth:user:update', true, NOW(), NOW()),
    ('3F2E5477-177A-42DD-B7E5-61CAF2E7B942', 'oauth:user:delete', true, NOW(), NOW()),
    ('A9BA6C8A-B590-45DC-BFA9-EFEBECC793C5', 'oauth:user:read', true, NOW(), NOW())
    """)
  end

  def down do
    execute("DELETE FROM scopes")
  end
end
