import Config

config :logger, :console, level: :info

config :logger,
  backends: [Timber.LoggerBackends.HTTP]

config :timber,
  api_key: System.get_env("TIMBER_API_KEY"),
  source_id: System.get_env("TIMBER_SOURCE_ID")

config :sentry,
  dsn: System.get_env("SENTRY_DSN")

config :prometheus, ElixirMicroserviceBase.MetricsExporterPlug,
  auth: {:basic, System.get_env("PROMETHEUS_USER"), System.get_env("PROMETHEUS_PASS")}
