# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :book_management,
  ecto_repos: [BookManagement.Repo]

# Configures the endpoint
config :book_management, BookManagement.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "PBE7tpAXLFdsM+BUSH0NjnwHMt9FRr8j9eTIDkeX+jw9FHjVK/oCNHfKtHJX672b",
  render_errors: [view: BookManagement.ErrorView, accepts: ~w(html json)],
  pubsub: [name: BookManagement.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  allowed_algos: ["HS512"],
  verify_module: Guardian.JWT,
  issuer: "BookManagement",
  ttl: { 30, :days },
  verify_issuer: true,
  secret_key: "N9P3p8x5vDFS3Nu4uWUjzkItLN4oNmVP",
  serializer: BookManagement.GuardianSerializer

config :exldap, :settings,
  server: "192.168.245.100",
  base: "DC=network21,DC=local",
  port: 389,
  ssl: false,
  user_dn: "CN=濱田 泰源,DC=network21,DC=local",
  password: "1192kamakura",
  search_timeout: 5000

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
