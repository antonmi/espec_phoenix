Code.require_file("spec/espec_phoenix_extend.ex")

# Mix.Task.run "ecto.create", ["--quiet"]
# Mix.Task.run "ecto.migrate", ["--quiet"]
Ecto.Adapters.SQL.Sandbox.mode(Rumbl.Repo, :manual)
