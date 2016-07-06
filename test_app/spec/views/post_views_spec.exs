defmodule TestApp.PostViewsSpec do
  use ESpec.Phoenix, view: TestApp.PostView, async: true

  alias TestApp.Post
  let :post, do: %Post{id: 1, title: "Post title 1"}
  let :post2, do: %Post{id: 2, title: "Post title 2"}
  let :posts, do: [post, post2]

  describe "index" do
    subject do: render("index.html", posts: posts)

    it do: should have_text("Listing posts")
    it do: should have_text_in("table td", post.title)
    it do: should have_text_in("table td", post2.title)
  end

  describe "show" do
    subject do: render("show.html", post: post)

    it do: should have_text("Show post")
    it do: should have_text_in("ul li", post.title)
    it do: should have_attribute_in("a", href: post_path(build_conn, :index))
  end

  describe "new" do
    let! :changeset, do: Post.changeset(%Post{})
    subject do: render("new.html", changeset: changeset)

    it do: should have_text("New post")
    it do: should have_attributes_in("form", action: "/posts", method: "post")
    it do: should have_selector("input#post_title")
    it do: should have_selector("input#post_body")
  end
end
