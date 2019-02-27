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
     applications: [:phoenix, :phoenix_pubsub, :phoenix_html, :cowboy, :logger, :gettext,
                    :phoenix_ecto, :postgrex, :comeonin, :info_sys],
     extra_applications: [:ex_unit]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "1.4.1"},
     {:phoenix_pubsub, "~> 1.0"},
     {:ecto, "2.1.6"},
     {:phoenix_ecto, "3.2.3"},
     {:postgrex, "0.13.3"},
     {:phoenix_html, "2.10.3"},
     {:phoenix_live_reload, "1.0.8", only: :dev},
     {:poison, "3.1.0"},
     {:gettext, "0.13.1"},
     {:comeonin, "3.2.0"},
     {:cowboy, "1.1.2"},
     {:info_sys, in_umbrella: true},
     {:espec_phoenix, path: "../../..", only: :test, app: false}
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
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
