defmodule Pagination.Schemas.Pagination do
  use Domain.Schema

  embedded_schema do
    field :page, :integer, default: 0
    field :page_size, :integer, default: 50
  end

  def changeset(schema_or_struct, params) do
    schema_or_struct
    |> cast(params, [:page, :page_size])
    |> validate_number(:page, greater_than_or_equal_to: 0)
    |> validate_number(:page_size, greater_than_or_equal_to: 1)
    |> validate_number(:page_size, less_than_or_equal_to: 100)
  end
end
