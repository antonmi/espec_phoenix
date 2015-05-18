defmodule App.Router do
  use App.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", App do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/posts", PostsController
    get "hello", PostsController, :hello 
    get "error", PostsController, :error 
  end

  # Other scopes may use custom stacks.
  scope "/api", App do
    pipe_through :api
    resources "/posts", Api.PostsController
  end
end
