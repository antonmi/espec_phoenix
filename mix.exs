defmodule EspecPhoenix.Mixfile do
  use Mix.Project

  @source_url "https://github.com/antonmi/espec_phoenix"
  @version "0.8.2"

  def project do
    [
      app: :espec_phoenix,
      name: "ESpec Phoenix",
      version: @version,
      elixir: ">= 1.10.0",
      package: package(),
      deps: deps(),
      preferred_cli_env: [
        espec: :test
      ]
    ]
  end

  def application do
    [applications: [:logger, :phoenix]]
  end

  defp deps do
    [
      {:espec, ">= 1.8.0"},
      {:phoenix, "~> 1.6"},
      {:phoenix_live_view, "~> 0.17"},
      {:ecto, ">= 2.1.6", only: [:dev, :test]},
      {:ex_doc, "~> 0.28", only: [:docs, :dev]},
      {:poison, "~> 5.0"},
      {:credo, "~> 1.6", only: :dev}
    ]
  end

  defp package do
    [
      description: "ESpec for Phoenix web framework.",
      files: ~w(lib mix.exs README.md),
      maintainers: ["Anton Mishchuk"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end
end
