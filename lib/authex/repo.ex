defmodule Authex.Repo do
  use Ecto.Repo,
    otp_app: :authex,
    adapter: Ecto.Adapters.Postgres
end
