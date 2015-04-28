defmodule App.Post do

	use App.Web, :model

	schema "posts" do
		field :title, :string
    field :text, :binary
	end

  def build(title, text) do
    %__MODULE__{title: title, text: text}
  end

end