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

		subject do: action :index

		it do: should be_successfull
		it do: should have_http_status 200
		
		it do: should have_in_assigns :posts
		it do: should have_in_assigns(:posts, posts)
		
		it do: String.contains?(subject.resp_body, "Post 1") |> should be true
	end

	describe "create" do
		
	end

end