defmodule App.PostsRequestsSpec do

	use ESpec.Phoenix, request: App.Endpoint

	describe "index" do
		
		before do
			post1 = %App.Post{title: "Post1", text: "Text 1"} |> App.Repo.insert
			post2 = %App.Post{title: "Post2", text: "Text 2"} |> App.Repo.insert
			{:ok, post1: post1, post2: post2}
		end

		subject! do: get(conn(),  App.Router.Helpers.posts_path(conn(), :index))

		it do: should be_successfull

		context "check body" do
			let :html, do: subject.resp_body

			it do: html |> should have_content "Post1"
			it do: html |> should have_text "Post2"
		end

		it do
			IO.inspect subject.private[:phoenix_flash]
		end
	end

	describe "create" do
		# let :params, do: %{"_csrf_token" => "vu/sjSqDJPtmuii+fVJQwINiR2XPhurxKjEKjLas+xA=", "_method" => "post", "format" => "html", "text" => "xcxxxxcxcxc", "title" => "dsfgsdfgsdfg"}
		let :params, do: %{"text" => "some text", "title" => "some post"}

		context "success" do
			
			it "create" do
				expect(fn ->
					post(conn(), "/posts", params)
				end).to change(fn -> App.PostsRepo.count end, 0, 1)
			end

			context "check record" do
				before do: post(conn(), posts_path(conn(), :index), params)
				let :post, do: App.PostsRepo.first

				it "check post" do
					post.title |> should eq "some post"
					post.text |> should eq "some text"
				end
			end

			context "chack conn" do
				let! :con, do: post(conn(), posts_path(conn(), :index), params)
				
				it do
					# require IEx; IEx.pry
					# IO.inspect con.private[:phoenix_flash]
				end

				it do: con |> should have_in_flash "notice"
				it do: con |> should have_in_flash("notice", "Post created!")

			end
		end



	end

end