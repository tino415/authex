defmodule Pagination.Page do
  @derive Jason.Encoder
  defstruct [
    :entries,
    :count,
    :page_count
  ]
end
