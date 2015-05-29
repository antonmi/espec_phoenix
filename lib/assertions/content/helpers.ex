defmodule ESpec.Phoenix.Assertions.Content.Helpers do

  def have_content(value), do: {ESpec.Phoenix.Assertions.Content.HaveText, value}
  def have_text(value), do: have_content(value)

  def have_selector(value), do: {ESpec.Phoenix.Assertions.Content.HaveSelector, value}
  
  def have_text_in(selector, value), do: {ESpec.Phoenix.Assertions.Content.HaveTextIn, [selector, value]}
  def have_content_in(selector, value), do: {ESpec.Phoenix.Assertions.Content.HaveTextIn, [selector, value]}
  
  def have_attributes_in(selector, value), do: {ESpec.Phoenix.Assertions.Content.HaveAttributesIn, [selector, value]}
  def have_attribute_in(selector, value), do: have_attributes_in(selector, value)
end

defmodule M do
  defstruct a: 1, b: 2 

  def m(%M{a: a}), do: a
end