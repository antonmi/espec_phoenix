defmodule ModelSpec do
  use ESpec.Phoenix, model: SomeModel

  defmodule Post do
    use Ecto.Schema

    schema "posts" do
      field(:title, :string)
      field(:body, :string)
    end
  end

  it "sets @model" do
    @model |> should(eq(SomeModel))
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
  end

  describe "imports from ESpec.Phoenix.Extend" do
    it "calls function from ModelHelpers" do
      model_helper_fun() |> should(eq(:fun))
    end
  end
end
