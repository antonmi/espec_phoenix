defmodule App.Models.PostSpec do

  use ESpec.Phoenix, model: App.Post

  describe "changeset" do
    context "not valid" do
      let :params, do: %{"title" => "", "text" => ""}
      subject Post.changeset(%App.Post{}, params)
      
      it do: should_not be_valid
    end

    context "valid" do
      let :params, do: %{"title" => "some title", "text" => "some text"}
      subject Post.changeset(%App.Post{}, params)

      it do: should be_valid
    end
  end

end