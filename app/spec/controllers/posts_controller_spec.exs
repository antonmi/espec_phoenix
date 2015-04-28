Code.require_file("lib/app/repo.ex")
defmodule App.PostsControllerSpec do

	use ESpec.Phoenix, controller: App.PostsController

	describe "index" do
		let :posts do
			[
				%App.Post{title: "Post 1", text: "Text 1"},
				%App.Post{title: "Post 2", text: "Text 2"}
			]
		end

		before do
			allow(App.PostsRepo).to accept(:all, fn -> posts end)
		end

		subject do: get(conn, :index)

		it do: should be_successfull
		
		it do

			should have_in_assigns :posts
		 	# require IEx; IEx.pry
		end

	end

end