defmodule App.PostsController do

	use App.Web, :controller
	plug :action

	def index(conn, _params) do
		posts = App.PostsRepo.all
		render conn, "index.html", posts: posts
	end

	def hello(conn, params) do
		text conn, params["hello"]
	end

end
