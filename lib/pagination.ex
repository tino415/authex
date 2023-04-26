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
    count = repo.one(count_query(query))
    page_count = ceil(count / pagination.page_size)

    %Page{
      count: count,
      page_count: page_count,
      entries: repo.all(entries_query(query, pagination))
    }
  end

  defp count_query(query) do
    query = reset_query(query)
    from(q in query, select: count(q.id))
  end

  defp reset_query(query) do
    %{query | order_bys: [], preloads: []}
  end

  defp entries_query(query, pagination) do
    from(q in query,
      limit: ^pagination.page_size,
      offset: ^pagination.page
    )
  end
end
