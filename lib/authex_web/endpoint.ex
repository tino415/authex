defmodule AuthexWeb.Endpoint do
  use Web.Endpoint

  plug(Plug.Logger)

  plug(Plug.Parsers,
    parsers: [:urlencoded, :json],
    json_decoder: Jason
  )

  plug(AuthexWeb.Router)

  def child_spec(_) do
    Bandit.child_spec(plug: __MODULE__)
  end
end
