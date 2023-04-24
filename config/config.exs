import Config

config :authex, ecto_repos: [Authex.Repo]

config :joken,
  default_signer: [
    signer_alg: "RS512",
    key_pem: File.read!(Path.join(Path.dirname(__DIR__), "priv/jwt/key.pem"))
  ]

import_config "#{config_env()}.exs"
