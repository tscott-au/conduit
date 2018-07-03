defmodule Conduit.Mixfile do
  use Mix.Project

  def project do
    [
      app: :conduit,
      version: "0.0.1",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps(),
    ]
  end

  def application do
    [
      mod: {Conduit.Application, []},
      extra_applications: [
        :logger,
        :runtime_tools,
        :eventstore,
      ],
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  defp deps do
    [
      {:commanded, "~> 0.16.0"},
      {:commanded_ecto_projections, "~> 0.6"},
      {:commanded_eventstore_adapter, "~> 0.4.0"},
      {:cowboy, "~> 1.0"},
      {:exconstructor, "~> 1.1"},
      {:ex_machina, "~> 2.2", only: :test},
      {:mix_test_watch, "~> 0.6.0", only: :dev, runtime: false},
      {:phoenix, "~> 1.3.3"},
      {:phoenix_ecto, "~> 3.2"},
      {:postgrex, ">= 0.0.0"},
      {:gettext, "~> 0.11"},
      {:uuid, "~> 1.1"},
    ]
  end

  defp aliases do
    [
      "event_store.reset": ["event_store.drop", "event_store.create", "event_store.init"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test": ["ecto.create --quiet", "ecto.migrate", "test"],
    ]
  end
end
