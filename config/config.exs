# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :auth_me,
  ecto_repos: [AuthMe.Repo]

# Configures the endpoint
config :auth_me, AuthMeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "61HB6mDqef5Q3v7IjnrLnHWUKQz+T9VZEW7+kysFBpwGdu74FnUJdDCnPbxLU8m9",
  render_errors: [view: AuthMeWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: AuthMe.PubSub,
  live_view: [signing_salt: "R/Z6RUhP"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason


config :auth_me, AuthMe.Guardian,
  issuer: "auth_me",
  secret_key: "w54DAoR0fiDDNwxdTq2whbzdumtziYbGY2yb6EtTVlnjpKBnEdbv8jM/WIec6ds2" # put the result of the mix command above here

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
