import Config

import_config "dev.secret.exs"

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :peerage,
  via: Peerage.Via.List,
  node_list: [:"elixir_microservice_base@127.0.0.1"],
  log_results: false
