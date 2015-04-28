defmodule ESpec.Phoenix.Controllers.Helpers do

	defmacro __using__(args) do
	  quote do
	  	
			def action(action, params \\ %{}) do
		  	conn = 	conn()
		  	|> put_private(:phoenix_controller, @controller)
		  	|> put_view(Phoenix.Controller.__view__(@controller))
				apply(@controller, action, [conn, params])
		  end
		end
	end


end