defmodule App.PostsRequestsSpec do

	use ESpec.Phoenix, request: App.Endpoint

	describe "index" do
		
		before do
			post1 = %App.Post{title: "Post1", text: "Text 1"} |> App.Repo.insert
			post2 = %App.Post{title: "Post2", text: "Text 2"} |> App.Repo.insert
			{:ok, post1: post1, post2: post2}
		end

		subject! do: get(conn(), posts_path(conn(), :index))

		it do: should be_successfull
		it do: should be_success

		context "check body" do
			let :html, do: subject.resp_body

			it do: html |> should have_content "Post1"
			it do: html |> should have_text "Post2"
		end
	end

	describe "create" do
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

			context "check conn" do
				subject! do: post(conn(), posts_path(conn(), :index), params)
				
				it do: should be_redirection
				it do: should be_redirect

				it do: should have_in_flash "notice"
				it do: should have_in_flash("notice", "Post created!")

				it do: should redirect_to(posts_path(conn(), :index))
			end
		end


	end

	describe "not found" do
		subject! do: get(conn(), "/not_found")
		it do: should be_not_found
		it do: should be_missing
	end

	describe "error" do
		subject! do: get(conn(), "/error")
		it do: should be_error
		it do: should be_server_error
	end

end

