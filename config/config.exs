# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :rabid_racoon, RabidRacoonWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ZN9cy732B7E5wpJGvigTdIya4fyl4rDC/GK9r/XG+0ykyvctjIzvpO0hJYWealzz",
  render_errors: [view: RabidRacoonWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: RabidRacoon.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
