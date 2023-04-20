import Config

config :authex, Authex.Repo,
  database: "authex_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
