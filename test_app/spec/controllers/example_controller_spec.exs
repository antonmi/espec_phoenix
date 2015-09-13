defmodule TestApp.ExampleControllerSpec do

  use ESpec.Phoenix, controller: TestApp.PostsController

  describe "index" do
    let :examples do
      [
        %TestApp.Example{title: "Example 1"},
        %TestApp.Example{title: "Example 2"},
      ]
    end

    before do
      allow(TestApp.Repo).to accept(:all, fn -> examples end)
    end

    subject do: action :index

    it do: should be_successful
    it do: should have_in_assigns(:examples, examples)

  end
end
