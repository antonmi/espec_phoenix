Code.require_file("spec/phoenix_helper.exs")

ESpec.start
  
ESpec.configure fn(config) ->
  config.before fn ->
     Ecto.Adapters.SQL.restart_test_transaction(App.Repo, [])
    {:ok, hello: :world}
  end
  
  config.finally fn(__) -> 
    __.hello
  end
end
