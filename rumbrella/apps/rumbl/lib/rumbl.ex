defmodule Rumbl do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      Rumbl.Repo,
      Rumbl.Endpoint,
      {Phoenix.PubSub, [name: Rumbl.PubSub, adapter: Phoenix.PubSub.PG2]}
    ]

    opts = [strategy: :one_for_one, name: Rumbl.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    Rumbl.Endpoint.config_change(changed, removed)
    :ok
  end
end
