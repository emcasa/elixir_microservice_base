defmodule ElixirMicroserviceBase.Metrics do
  @moduledoc false
  require Prometheus.Registry

  alias ElixirMicroserviceBase.{
    PlugPipelineInstrumenter,
    PlugExporter
  }

  def setup do
    PlugPipelineInstrumenter.setup()
    PlugExporter.setup()
    Prometheus.Registry.register_collector(:prometheus_process_collector)
  end
end
