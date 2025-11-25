defmodule ControllerSpec do
  use ESpec.Phoenix, controller: SomeController

  defmodule Post do
    use Ecto.Schema

    schema "posts" do
      field(:title, :string)
      field(:body, :string)
    end
  end

  it "sets @model" do
    expect(@controller) |> to(eq(SomeController))
  end

  describe "imports" do
    it "call Ecto function" do
      primary_key(%Post{}) |> should(eq(id: nil))
    end

    it "call Ecto.Changeset function" do
      changeset1 = cast(%Post{}, %{title: "Title"}, [:title])
      changeset2 = cast(%Post{}, %{title: "New title", body: "Body"}, [:title, :body])
      changeset = merge(changeset1, changeset2)
      changeset.changes |> should(eq(%{body: "Body", title: "New title"}))
    end

    it "call Ecto.Query function" do
      from(p in Post) |> should(be_struct(Ecto.Query))
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
      controller_helper_fun() |> to(eq(:fun))
    end
  end
end
