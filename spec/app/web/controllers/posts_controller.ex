defmodule App.PostsController do

	use App.Web, :controller
	plug :action

	def index(conn, _params) do
		render conn, "index.html"
	end

	def hello(conn, params) do
		text conn, params["hello"]
	end

end
