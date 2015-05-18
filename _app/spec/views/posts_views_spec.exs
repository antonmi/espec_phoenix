defmodule App.Views.PostsViewsSpec do

  use ESpec.Phoenix, view: App.PostsView

  describe "index html" do
    let :posts do
      [
        %App.Post{title: "Post 1", text: "Text 1"},
        %App.Post{title: "Post 2", text: "Text 2"}
      ]
    end

    subject do: render("index.html", posts: posts)

    it do: should have_content "Post 1"
    it do: should have_text "Post 2"
  end
end