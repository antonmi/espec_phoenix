defmodule Rumbl.Mixfile do
  use Mix.Project

  def project do
    [app: :rumbl,
     version: "0.0.1",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     preferred_cli_env: [espec: :test],
     aliases: aliases(),
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Rumbl, []},
     extra_applications: [:ex_unit]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.6"},
     {:phoenix_pubsub, "~> 2.0"},
     {:ecto, "3.7.1"},
     {:ecto_sql, "3.7.1"},
     {:phoenix_ecto, "4.4.0"},
     {:postgrex, "0.15.13"},
     {:phoenix_html, "3.1.0"},
     {:phoenix_live_reload, "1.3.3", only: :dev},
     {:poison, "3.1.0"},
     {:jason, "~> 1.0"},
     {:gettext, "0.13.1"},
     {:cowboy, "2.9.0"},
     {:info_sys, in_umbrella: true},
     {:espec_phoenix, path: "../../..", only: :test, app: false},
     {:bcrypt_elixir, "~> 2.3"}
      ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     test: ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
