use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :app, App.Endpoint,
  secret_key_base: "xJrLO0ZIBJ3ZV0JzK8cRmxuxu+se9PS1GSrrz76hMRmMhnalnaPkA5hTl4p00V0d"

# Configure your database
config :app, App.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "app_prod",
  size: 20 # The amount of database connections in the pool
