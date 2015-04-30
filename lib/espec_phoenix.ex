defmodule ESpec.Phoenix do

	defmacro __using__(args) do
		
		cond do
			Keyword.has_key?(args, :model) ->
				quote do
					use ESpec
					@model Keyword.get(unquote(args), :model)
					
					import Ecto.Model
					import Ecto.Query, only: [from: 2]
					
					import ESpec.Phoenix.Assertions.Changeset.Helpers
					
					use ESpec.Phoenix.Extend, :model
				end
		
			Keyword.has_key?(args, :controller) ->
				quote do
					use ESpec
					@controller Keyword.get(unquote(args), :controller)
					
					import Phoenix.Controller
					use Phoenix.ConnTest

					use ESpec.Phoenix.Controllers.Helpers
					import ESpec.Phoenix.Assertions.Helpers

					use ESpec.Phoenix.Extend, :controller
				end
			
			Keyword.has_key?(args, :request) ->
				quote do
					use ESpec
					@endpoint Keyword.get(unquote(args), :request)
					
					import ESpec.Phoenix.Assertions.Content.Helpers
					use Phoenix.ConnTest
					import ESpec.Phoenix.Assertions.Helpers

					use ESpec.Phoenix.Extend, :request
				end	
			
			Keyword.has_key?(args, :router) ->
				quote do
					use ESpec
					@router Keyword.get(unquote(args), :router)
					use ESpec.Phoenix.Extend, :router
				end	

			Keyword.has_key?(args, :view) ->
				quote do
					use ESpec
					@view Keyword.get(unquote(args), :view)
					
					use Phoenix.ConnTest
					
					import ESpec.Phoenix.Assertions.Content.Helpers
					use ESpec.Phoenix.Views.Helpers

					use ESpec.Phoenix.Extend, :view
				end
			
			true -> :ok	
		end

	end  


end