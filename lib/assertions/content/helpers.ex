defmodule ESpec.Phoenix.Assertions.Content.Helpers do

  def have_content(content) when is_binary(content), do: ESpec.AssertionHelpers.have(content)
  def have_text(content), do: have_content(content)

  def have_selector(value), do: {ESpec.Phoenix.Assertions.Content.HaveSelector, value}
  
  def have_text_in(selector, value), do: {ESpec.Phoenix.Assertions.Content.HaveTextIn, [selector, value]}
  def have_content_in(selector, value), do: {ESpec.Phoenix.Assertions.Content.HaveTextIn, [selector, value]}
  
end