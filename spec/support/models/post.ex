defmodule Phoenix.Models.Post do

	use Ecto.Model

	schema "posts" do
		field :title, :string
    field :text, :binary
	end

end