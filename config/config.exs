# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :nobinalo,
  ecto_repos: [Nobinalo.Repo]

config :nobinalo, Nobinalo.Repo, migration_timestamps: [type: :timestamptz]

# Configures the endpoint
config :nobinalo, NobinaloWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base:
    "0huYgDZUqk4wRqpjfs2+MEWzkn25UqWWK4mvmfqb2bUwFE3eT06JmhZ8b9ppDPdl",
  render_errors: [
    view: NobinaloWeb.ErrorView,
    accepts: ~w(html json),
    layout: false
  ],
  pubsub_server: Nobinalo.PubSub,
  live_view: [signing_salt: "2B/8ytAv"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ueberauth, Ueberauth,
  providers: [
    github:
      {Ueberauth.Strategy.Github, [default_scope: "read:user,user:email"]},
    # google: {Uberauth.Strategy.Google, []},
    discord: {Ueberauth.Strategy.Discord, []}
  ]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: System.fetch_env!("GITHUB_CLIENT_ID"),
  client_secret: System.fetch_env!("GITHUB_CLIENT_SECRET")

# config :ueberauth, Ueberauth.Strategy.Google.OAuth,
#   client_id: System.get_env("GOOGLE_CLIENT_ID"),
#   client_secret: System.get_env("GOOGLE_CLIENT_SECRET")

config :ueberauth, Ueberauth.Strategy.Discord.OAuth,
  client_id: System.get_env("DISCORD_CLIENT_ID"),
  client_secret: System.get_env("DISCORD_CLIENT_SECRET")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
