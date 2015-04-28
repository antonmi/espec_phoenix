use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :app, App.Endpoint,
  secret_key_base: "9VJ8OEM5BtozuEjLiJfoiZPIu4OiLXoUScnS+oNZIqKAAJtNWh2+qmxRh0Zw44nd"

# Configure your database
config :app, App.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "app_prod"
