defmodule App.PostsRepo do

	alias App.Repo
	alias App.Post
	import Ecto.Query

	def all, do: Repo.all(from m in Post, select: m)

  def count do
    query = from(un in Post, select: count(un.id))
    Repo.one(query)
  end

  def first do
		query = from un in Post, limit: 1
    Repo.one(query)
  end




end