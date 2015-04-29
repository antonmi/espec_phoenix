defmodule App.Post do

	use App.Web, :model

	schema "posts" do
		field :title, :string
    field :text, :binary
	end

  def build(title, text) do
    %__MODULE__{title: title, text: text}
  end

  def new(params), do: App.Post.build(params["title"], params["text"])

  def changeset(post, params) do
		post
    |> cast(params, ~w(title text), ~w())
    |> validate_length(:title, min: 1)
    |> validate_length(:text, min: 1)
  end

  def full_error_message(changeset) do
    Enum.map(changeset.errors, &__MODULE__.error_message(&1)) |> Enum.join("\n")
  end

	def error_message({:title, _}), do: "Missing title!"
  def error_message({:text, _}), do: "Missing text!"
  def error_message(_), do: "Some error"

end