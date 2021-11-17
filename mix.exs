defmodule EspecPhoenix.Mixfile do
  use Mix.Project

  @version "0.7.1"

  def project do
    [
      app: :espec_phoenix,
      name: "ESpec Phoenix",
      version: @version,
      elixir: ">= 1.6.0",
      description: description(),
      package: package(),
      deps: deps(),
      source_url: "https://github.com/antonmi/espec_phoenix",
      preferred_cli_env: [espec: :test]
    ]
  end

  def application do
    [applications: [:logger, :phoenix]]
  end

  defp description do
    "ESpec for Phoenix web framework."
  end

  defp deps do
    [
      {:espec, ">= 1.8.0"},
      {:phoenix, "~> 1.6"},
      {:phoenix_live_view, "~> 0.16"},
      {:ecto, ">= 2.1.6", only: [:dev, :test]},
      {:ex_doc, "~> 0.25", only: :dev},
      {:poison, "~> 3.1 or ~> 4.0"},
      {:credo, "~> 1.6", only: :dev}
    ]
  end

  defp package do
    [
      files: ~w(lib mix.exs README.md),
      maintainers: ["Anton Mishchuk"],
      licenses: ["MIT"],
      links: %{"github" => "https://github.com/antonmi/espec_phoenix"}
    ]
  end
end
