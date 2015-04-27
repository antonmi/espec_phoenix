defmodule ESpec.Phoenix do

	defmacro __using__(args) do
		
		cond do
			Keyword.has_key?(args, :model) ->
	    	quote do
 					use ESpec
					@model Keyword.get(unquote(args), :model)
					
      		import Ecto.Model
					import Ecto.Query, only: [from: 2]
				end
	  
	    Keyword.has_key?(args, :controller) ->
	    	quote do
 					use ESpec
					@controller Keyword.get(unquote(args), :controller)
					
					use Plug.Test
					import Phoenix.Controller

					use ESpec.Phoenix.Controllers.Helpers
					import ESpec.Phoenix.Assertions.Helpers
				end
			
			Keyword.has_key?(args, :request) ->
	    	quote do
 					use ESpec
					@endpoint Keyword.get(unquote(args), :request)
					
					use Phoenix.ConnTest
					import ESpec.Phoenix.Assertions.Helpers
				end	
			
			Keyword.has_key?(args, :view) ->
	    	quote do
 					use ESpec
					@view Keyword.get(unquote(args), :view)
					
					use ESpec.Phoenix.Views.Helpers
				end
			
			true -> :ok	
		end

  end  


end