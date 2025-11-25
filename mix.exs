defmodule EspecPhoenix.Mixfile do
  use Mix.Project

  @source_url "https://github.com/antonmi/espec_phoenix"
  @version "0.9.0"

  def project do
    [
      app: :espec_phoenix,
      name: "ESpec Phoenix",
      version: @version,
      elixir: ">= 1.16.0",
      package: package(),
      deps: deps(),
      source_url: @source_url,
      preferred_cli_env: [espec: :test]
    ]
  end

  def application do
    [applications: [:logger, :phoenix, :ecto, :espec, :phoenix_live_view]]
  end

  defp deps do
    [
      {:espec, path: "/Users/anton.mishchukkloeckner.com/elixir/espec"},
      {:phoenix, "~> 1.8"},
      {:phoenix_view, "~> 2.0"},
      {:phoenix_live_view, "~> 1.1"},
      {:ecto, "~> 3.13", only: [:dev, :test]},
      {:ex_doc, "~> 0.39", only: [:docs, :dev]},
      {:credo, "~> 1.7", only: :dev}
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
