defmodule App.ApiPostsRequestsSpec do

	use ESpec.Phoenix, request: App.Endpoint

	describe "index" do
		
		before do
			post1 = %App.Post{title: "Post1", text: "Text 1"} |> App.Repo.insert
			post2 = %App.Post{title: "Post2", text: "Text 2"} |> App.Repo.insert
			{:ok, post1: post1, post2: post2}
		end

		subject! do: get(conn(), "/api/posts")

		it do: should be_successfull

		context "check body" do
			let :json do
			 	{:ok, data } = Poison.decode(subject.resp_body)
			 	data
			end 

			let :first, do: List.first(json)
			let :last, do: List.last(json)

			it do: first["text"] |> should eq "Text 1"
			it do: last["text"] |> should eq "Text 2"
		
	
		end

	end

end