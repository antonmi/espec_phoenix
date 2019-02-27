defmodule EspecPhoenix.Mixfile do
  use Mix.Project

  @version "0.6.10"

  def project do
    [app: :espec_phoenix,
     name: "ESpec Phoenix",
     version: @version,
     elixir: ">= 1.5.3",
     description: description(),
     package: package(),
     deps: deps(),
     source_url: "https://github.com/antonmi/espec_phoenix",
     preferred_cli_env: [espec: :test]]
  end

  def application do
    [applications: [:logger, :phoenix]]
  end

  defp description do
    "ESpec for Phoenix web framework."
  end

  defp deps do
    [
      {:espec, ">= 1.6.0"},
      {:phoenix, "~> 1.3"},
      {:ecto, ">= 2.0.0", only: [:dev, :test]},
      {:ex_doc, "~> 0.16", only: :dev},
      {:credo, "~> 0.8", only: :dev},
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
