defmodule App.PostsController do

  use App.Web, :controller
  plug :action

  def index(conn, _params) do
    posts = App.PostsRepo.all
    render conn, "index.html", posts: posts
  end

  def new(conn, params) do
    post = App.Post.new(params)
    render conn, "new.html", changeset: %Ecto.Changeset{changes: post, model: post}
  end

  def create(conn, params) do
    post = App.Post.new(params)
    changeset  = App.Post.changeset(post, params)
    if changeset.valid? do
      post = Repo.insert(changeset)
      conn |> put_flash(:notice, "Post created!")
      |> redirect to: posts_path(conn, :index)
    else
      changeset = %{ changeset | model: post}
      conn |> put_flash(:error, App.Post.full_error_message(changeset))
      |> render "new.html", changeset: changeset
    end
  end


  def hello(conn, params) do
    text conn, params["hello"]
  end

  def error(conn, params) do
    conn |> put_status(500)
    |> render "index.html", posts: []
  end

end
