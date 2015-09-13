defmodule TestApp.Models.PostSpec do
  use ESpec.Phoenix, model: TestApp.Post
  alias TestApp.Post

  let :valid_attrs, do: %{title: "Post title", body: "some content"}
  let :invalid_attrs, do: %{title: "", body: "short body"}

  context "valid changeset" do
    subject do: Post.changeset(%Post{}, valid_attrs)
    it do: should be_valid
  end

end
