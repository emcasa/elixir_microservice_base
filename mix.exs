defmodule ElixirMicroserviceBase.Umbrella.Mixfile do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.0", only: [:dev, :test], runtime: false},
      {:timber, "~> 3.1"},
      {:timber_plug, "~> 1.0"},
      {:excoveralls, "~> 0.10", only: :test},
      {:junit_formatter, "~> 3.0", only: :test, runtime: false},
      {:prometheus_ex, "~> 3.0"},
      {:prometheus_plugs, "~> 1.1"},
      {:prometheus_process_collector, "~> 1.0"},
      {:jason, "~> 1.1"},
      {:uuid, "~> 1.1"},
      {:sentry, "~> 7.0"},
      {:plug_cowboy, "~> 2.0"},
      {:plug_checkup, "~> 0.5"},
      {:httpoison, "~> 1.3"},
      {:telemetry, "~> 0.4"}
    ]
  end
end
