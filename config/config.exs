# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :archive,
  ecto_repos: [Archive.Repo]

# Configures the endpoint
config :archive, ArchiveWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "aOzzuAY5KPQUdtXPkuZpsuTEDGT4JHPLWfprx7MaErLhbGZNaUlSbt+YWYOliw1x",
  render_errors: [view: ArchiveWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Archive.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :archive, :generators,
  binary_id: true

config :archive, Archive.Repo, migration_primary_key: [name: :uuid, type: :binary_id]

config :ueberauth, Ueberauth,
base_path: "/auth",
providers: [
  identity: {Ueberauth.Strategy.Identity, [
    callback_methods: ["POST"],
    nickname_field: :username,
    param_nesting: "user",
    uid_field: :username
  ]},
  # facebook: {Ueberauth.Strategy.Facebook, [profile_fields: "name,email,about"]},
  # linkedin: {Ueberauth.Strategy.LinkedIn, [default_scope: "r_basicprofile r_emailaddress"]},
  github: { Ueberauth.Strategy.Github, [default_scope: "user:email"] }
]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
