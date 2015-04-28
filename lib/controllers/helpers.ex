defmodule ESpec.Phoenix.Controllers.Helpers do

	defmacro __using__(args) do
	  quote do


	  	def conn do
	  	 	Phoenix.ConnTest.conn()
	  	 	|>  put_private(:phoenix_controller, @controller)
	  	end


		  def get(conn, action, params \\ %{}) do
		  	conn = conn
		  	|> put_view(Phoenix.Controller.__view__(@controller))
				apply(@controller, action, [conn, params])
		  end

		end
	end


end