defmodule OtherSpec do
  use ESpec.Phoenix

  it "tests evidence" do
    expect(1) |> to(eq 1)
  end
end
