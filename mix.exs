defmodule EspecPhoenix.Mixfile do
  use Mix.Project

  @version "0.1.2"

  def project do
    [app: :espec_phoenix,
     name: "ESpec Phoenix",
     version: @version,
     elixir: "~> 1.0",
     description: description,
     package: package,
     deps: deps,
     source_url: "https://github.com/antonmi/espec_phoenix",
     preferred_cli_env: [espec: :test],
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :phoenix]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options

  defp description do
    """
      ESpec for Phoenix web framework.
    """
  end

  defp deps do
    [
      {:espec, "0.6.3"},
      {:phoenix, ">= 0.0.0"},
      {:floki, "~> 0.3.0"}
    ]
  end

  defp package do
   [
     files: ~w(lib mix.exs README.md),
     contributors: ["Anton Mishchuk"],
     licenses: ["MIT"],
     links: %{"github" => "https://github.com/antonmi/espec_phoenix"}
   ]
 end
end
