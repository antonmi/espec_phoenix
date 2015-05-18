defmodule App.ExampleViewsSpec do

  use ESpec.Phoenix, view: App.ExamplesView

  describe "index html" do
    let :examples do
      [
        %App.Example{title: "Example 1"},
        %App.Example{title: "Example 2"},
      ]
    end

    subject do: render("index.html", examples: examples)

    it do: should have_content "Example 1"
    it do: should have_text "Example 2"
  end
end  
