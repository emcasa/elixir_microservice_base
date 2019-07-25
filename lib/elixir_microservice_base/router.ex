defmodule ElixirMicroserviceBase.Router do
  use Plug.Router

  plug(ElixirMicroserviceBase.PlugExporter)
  plug(Timber.Plug.HTTPContext)
  plug(Timber.Plug.Event)
  plug(:match)
  plug(:dispatch)

  checks = [
    %PlugCheckup.Check{
      name: "server",
      module: ElixirMicroserviceBase.HealthCheck,
      function: :ping
    }
  ]

  forward(
    "/health-check",
    to: PlugCheckup,
    init_opts: PlugCheckup.Options.new(json_encoder: Jason, checks: checks)
  )

  match _ do
    send_resp(conn, 404, "Not found")
  end
end
