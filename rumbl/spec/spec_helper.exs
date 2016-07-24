Code.require_file("spec/phoenix_helper.exs")
Code.require_file("spec/support/controller_setup.ex")

ESpec.configure fn(config) ->
  config.before fn(opts) ->
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Rumbl.Repo)

    if controller = opts[:controller] do
      ControllerSetup.setup(controller, opts)
    else
      :ok
    end
  end

  config.finally fn(shared) ->
    if controller = shared[:controller] do
      ControllerSetup.on_exit(controller, shared)
    end
    Ecto.Adapters.SQL.Sandbox.checkin(Rumbl.Repo, [])
  end
end
