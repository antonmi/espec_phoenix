defmodule TestApp.Models.PostSpec do
  use ESpec.Phoenix, model: TestApp.Post
  alias TestApp.Post

  let :valid_attrs, do: %{title: "Post title", body: "some body content"}
  let :invalid_attrs, do: %{title: "", body: "short body"}

  context "valid changeset" do
    subject do: Post.changeset(%Post{}, valid_attrs)
    it do: should be_valid
  end

  context "invalid changeset" do
    subject do: Post.changeset(%Post{}, invalid_attrs)

    it do: should_not be_valid
    it do: should have_errors([:title, :body])

    it "checks title" do
      should have_errors(:title)
      should have_errors(title: "can't be blank")
    end

    it "checks body" do
      should have_errors(body: {"should be at least %{count} characters", [count: 15]})
    end
  end

  context "Save and load records" do
    before do
      changeset = Post.changeset(%Post{}, valid_attrs)
      {:ok, model} = Repo.insert(changeset)
      {:ok, model: model}
    end

    it do: expect(Repo.all(Post)).to have_size(1)
    let :record, do: Repo.get(Post, shared[:model].id)
    it "checks record" do
      expect(record.title).to eq("Post title")
      expect(record.body).to eq("some body content")
    end
  end
end
