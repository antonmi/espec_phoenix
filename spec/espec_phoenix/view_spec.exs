defmodule ViewSpec do
  use ESpec.Phoenix, view: SomeView

  it "sets @view" do
    expect(@view) |> to(eq(SomeView))
  end

  describe "imports" do
    it "call Phoenix.View function" do
      template_path_to_name(
        "lib/templates/admin/users/show.html.eex",
        "lib/templates"
      )
      |> should(eq("admin/users/show.html"))
    end

    it "call Phoenix.ConnTest.build_conn" do
      build_conn() |> should(be_struct(Plug.Conn))
    end

    it "call Plug.Conn function" do
      assign(build_conn(), :a, 1).assigns |> should(eq(%{a: 1}))
    end
  end

  describe "imports from ESpec.Phoenix.Extend" do
    it "calls function from ModelHelpers" do
      view_helper_fun() |> should(eq(:fun))
    end
  end
end
