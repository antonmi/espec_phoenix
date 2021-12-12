defmodule EspecPhoenix.Mixfile do
  use Mix.Project

  @source_url "https://github.com/antonmi/espec_phoenix"
  @version "0.8.0"

  def project do
    [
      app: :espec_phoenix,
      name: "ESpec Phoenix",
      version: @version,
      elixir: ">= 1.6.0",
      package: package(),
      deps: deps(),
      docs: docs(),
      preferred_cli_env: [
        docs: :docs,
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
      {:phoenix_live_view, "~> 0.16"},
      {:ecto, ">= 2.1.6", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: :docs, runtime: false},
      {:poison, "~> 3.1 or ~> 4.0"},
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

  defp docs do
    [
      extras: [
        "LICENSE.md": [title: "License"],
        "README.md": [title: "Overview"]
      ],
      main: "readme",
      source_url: @source_url,
      source_ref: "v#{@version}",
      formatters: ["html"]
    ]
  end
end
