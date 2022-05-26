import Config

config :rumbl, Rumbl.Endpoint,
  http: [port: 4001],
  server: false

config :logger, level: :warn

config :rumbl, Rumbl.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "rumbl_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
