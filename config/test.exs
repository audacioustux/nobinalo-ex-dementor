use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :nobinalo, Nobinalo.Repo,
  username: "postgres",
  password: "postgres",
  database: "nobinalo_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Relax crypto strength a bit during testing
config :argon2_elixir, t_cost: 1, m_cost: 8

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :nobinalo, NobinaloWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
