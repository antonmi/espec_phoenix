defmodule ESpec.Phoenix.Extend do
	
	def model do

	end

	def controller do
    quote do
      alias App.Repo
      import App.Router.Helpers
    end
  end

 	def request do
    quote do
      alias App.Repo
      alias App.Post
      import App.Router.Helpers
    end
  end

  def view do

  end


	defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end


end