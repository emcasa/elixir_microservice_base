defmodule ElixirMicroserviceBase.Application do
  @moduledoc false

  use Application

  @port Application.get_env(:elixir_microservice_base, :port, 4000)

  def start(_type, _args) do
    ElixirMicroserviceBase.Metrics.setup()
    {:ok, _} = Logger.add_backend(Sentry.LoggerBackend)

    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: ElixirMicroserviceBase.Router,
        options: [port: @port]
      )
    ]

    opts = [strategy: :one_for_one, name: ElixirMicroserviceBase.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
