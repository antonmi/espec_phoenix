use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :app, App.Endpoint,
  secret_key_base: "2ipP8UjBSTs5Jx/ZO4Vd7VHk92JObs4CFmqlkhyIm/BJhquxN4B62S7WIt9JQnjA"

# Configure your database
config :app, App.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "app_prod",
  size: 20 # The amount of database connections in the pool
