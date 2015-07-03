Code.require_file("spec/espec_phoenix/requires.ex")

defmodule ControllerOptionSpec do
  use ESpec.Phoenix, controller: App.PostsController

  context "use ESpec.Phoenix.Controllers.Helpers" do
    let :response, do: action(:hello, %{"hello" => "world"})
    it do: response.resp_body |> should eq("world")
  end

  context "import ESpec.Phoenix.Assertions.Helpers" do
    subject action(:hello, %{"hello" => "world"})
    it do: should be_successfull
  end

end