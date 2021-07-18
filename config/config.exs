# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :art_collection,
  ecto_repos: [ArtCollection.Repo]

# Configures the endpoint
config :art_collection, ArtCollectionWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "jcBZZ36hMQKUBYOaUBSan9vl4+gNVSdp2sQmCca7xRJTl00lCI+Z+KqX/YkMpkdB",
  render_errors: [view: ArtCollectionWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ArtCollection.PubSub,
  live_view: [signing_salt: "JUr34HgX"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :torch,
  otp_app: :art_collection,
  template_format: "eex"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
