defmodule ESpec.Phoenix.Assertions.Content.Helpers do

	def have_content(content) when is_binary(content), do: ESpec.AssertionHelpers.have(content)
	def have_text(content), do: have_content(content)

	
end