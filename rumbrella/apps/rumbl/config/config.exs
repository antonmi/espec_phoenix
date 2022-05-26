import Config

# General application configuration
config :rumbl,
  ecto_repos: [Rumbl.Repo]

# Configures the endpoint
config :rumbl, Rumbl.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "AVqfxpXem5eOdnlZfHmSYbcC6evHv3HvNBarBz1AYRX0QxjbM+hCje31n9o0TmrT",
  render_errors: [view: Rumbl.ErrorView, accepts: ~w(html json)],
  pubsub_server: Rumbl.PubSub

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
