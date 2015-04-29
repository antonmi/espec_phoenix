defmodule App.Api.PostsController do

	use App.Web, :controller
	plug :action

	def index(conn, _params) do
		posts = App.PostsRepo.all
		json conn, posts
	end

end
