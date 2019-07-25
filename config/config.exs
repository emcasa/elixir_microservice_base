import Config

config :sentry,
  included_environments: ~w(production staging),
  environment_name: System.get_env("ENV") || "development"

config :prometheus, ReWeb.PlugExporter,
  path: "/metrics",
  format: :auto,
  registry: :default,
  auth: false

import_config "#{Mix.env()}.exs"
