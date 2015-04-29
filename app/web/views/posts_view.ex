defmodule App.PostsView do
	use App.Web, :view

	defp persist?(changeset) do
    if changeset.model.id, do: true, else: false
  end

	defp button_text(changeset) do
    if persist?(changeset), do: "Update", else: "Create"
  end

  def has_error?(changeset, key) do
    Keyword.has_key?(changeset.errors, key)
  end
end