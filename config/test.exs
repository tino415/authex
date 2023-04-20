import Config

config :authex, Authex.Repo,
  database: "authex_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
