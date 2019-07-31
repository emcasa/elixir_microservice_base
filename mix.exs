defmodule ElixirMicroserviceBase.Umbrella.Mixfile do
  use Mix.Project

  def project do
    [
      app: :elixir_microservice_base,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test]
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {ElixirMicroserviceBase.Application, []}
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

  defp aliases do
    [
      "git.hook": &git_hook/1
    ]
  end

  defp git_hook(_) do
    Mix.shell().cmd("cp priv/git/pre-commit .git/hooks/pre-commit")
    Mix.shell().cmd("chmod +x .git/hooks/pre-commit")
  end
end
