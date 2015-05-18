defmodule App.ExampleModelSpec do

  use ESpec.Phoenix, model: App.Example

  let :example, do: %App.Example{title: "Example 1"}
  it do: example.title |> should eq "Example 1"

end
