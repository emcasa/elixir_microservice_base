import Config

config :logger, :console, level: :info

config :logger,
  backends: [Timber.LoggerBackends.HTTP]
