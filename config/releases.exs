import Config

config :elixir_microservice_base,
  port: System.fetch_env!("PORT")

config :logger, :console, level: :info

config :logger,
  backends: [Timber.LoggerBackends.HTTP]

config :timber,
  api_key: System.fetch_env!("TIMBER_API_KEY"),
  source_id: System.fetch_env!("TIMBER_SOURCE_ID")

config :sentry,
  enable_source_code_context: true,
  root_source_code_path: File.cwd!(),
  dsn: System.fetch_env!("SENTRY_DSN")

config :prometheus, ElixirMicroserviceBase.MetricsExporterPlug,
  auth: {:basic, System.fetch_env!("PROMETHEUS_USER"), System.fetch_env!("PROMETHEUS_PASS")}
