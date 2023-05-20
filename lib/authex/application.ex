defmodule Authex.Application do
  use Application

  @impl true
  def start(_type, _args) do
    opts = [strategy: :one_for_one, name: Authex.Supervisor]
    Supervisor.start_link(children(), opts)
  end

  if Mix.env() != :test do
    def children do
      [AuthexWeb.Endpoint, Authex.Repo]
    end
  else
    def children do
      [Authex.Repo]
    end
  end
end
