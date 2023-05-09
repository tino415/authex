defmodule Authex.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AuthexWeb.Endpoint,
      Authex.Repo
    ]

    opts = [strategy: :one_for_one, name: Authex.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
