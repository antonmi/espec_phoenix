defmodule App.ExampleControllerSpec do

  use ESpec.Phoenix, controller: App.PostsController

  describe "index" do
    let :examples do
      [
        %App.Example{title: "Example 1"},
        %App.Example{title: "Example 2"},
      ]
    end

    before do
      allow(App.Repo).to accept(:all, fn -> examples end)
    end

    subject do: action :index

    it do: should be_successfull
    it do: should have_in_assigns(:examples, examples)
    
  end
end
