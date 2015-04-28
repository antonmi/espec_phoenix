defmodule App.PostsRepo do

	alias App.Repo
	alias App.Post
	import Ecto.Query

	def all, do: Repo.all(from m in Post, select: m)




end