defmodule App.PostsRequestsSpec do

  use ESpec.Phoenix, request: App.Endpoint

  describe "index" do
    
    before do
      ex1 = %App.Example{title: "Example 1"} |> App.Repo.insert
      ex2 = %App.Example{title: "Example 2"} |> App.Repo.insert
      {:ok, ex1: ex1, ex2: ex2}
    end

    subject! do: get(conn(), examples_path(conn(), :index))

    it do: should be_successfull
    it do: should be_success

    context "check body" do
      let :html, do: subject.resp_body

      it do: html |> should have_content __.ex1.title
      it do: html |> should have_text __.ex2.title
    end
  end
end
