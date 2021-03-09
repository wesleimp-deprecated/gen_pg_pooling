# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :gen_pg_pooling,
  ecto_repos: [GenPgPooling.Repo]

config :gen_pg_pooling_web,
  ecto_repos: [GenPgPooling.Repo],
  generators: [context_app: :gen_pg_pooling]

# Configures the endpoint
config :gen_pg_pooling_web, GenPgPoolingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "AjAiWbry1ytwsxR9uDkVT9frOYfC7RpB8qbq+HHuUUj4jRwgBTUxsIoD9foQ8EAb",
  render_errors: [view: GenPgPoolingWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: GenPgPooling.PubSub,
  live_view: [signing_salt: "ocgAKsGw"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
