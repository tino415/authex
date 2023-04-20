defmodule Pagination do
  alias Pagination.Page
  alias Pagination.Schemas
  alias Ecto.Changeset

  import Ecto.Query

  def cast_pagination(params) do
    %Schemas.Pagination{}
    |> Schemas.Pagination.changeset(params)
    |> Changeset.apply_action(:insert)
  end

  def paginate(query, repo, pagination) do
    count = repo.count(query)

    page_count = count / pagination.page_size

    entries = 
      from(q in query,
        limit: ^pagination.page_size,
        offset: ^pagination.page
      )
      |> repo.all()

    %Page{
      count: count,
      page_count: page_count,
      entries: entries
    }
  end
end
