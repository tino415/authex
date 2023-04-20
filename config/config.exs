import Config

config :authex, ecto_repos: [Authex.Repo]

import_config "#{config_env()}.exs"
