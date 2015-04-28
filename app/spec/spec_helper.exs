ESpec.start
	
ESpec.configure fn(config) ->
	config.before fn ->
		{:ok, hello: :world}
	end
	
	config.finally fn(__) -> 
		__.hello
	end
end
