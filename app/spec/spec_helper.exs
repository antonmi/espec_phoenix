ESpec.start

Mix.Task.run "ecto.create", ["--quiet"]
Mix.Task.run "ecto.migrate", ["--quiet"]
Ecto.Adapters.SQL.begin_test_transaction(App.Repo)

	
ESpec.configure fn(config) ->
	config.before fn ->
		Ecto.Adapters.SQL.restart_test_transaction(App.Repo, [])
	end
	
	config.finally fn(__) -> 
		
	end
end
