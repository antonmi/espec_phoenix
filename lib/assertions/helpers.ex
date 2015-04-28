defmodule ESpec.Phoenix.Assertions.Helpers do

  def have_http_status(value), do: {ESpec.Phoenix.Assertions.HaveHttpStatus, value}
  def be_successfull, do: {ESpec.Phoenix.Assertions.BeSuccessfull, []}
  def have_in_assigns(key), do: {ESpec.Phoenix.Assertions.HaveInAssigns, [key]}
  def have_in_assigns(key, value), do: {ESpec.Phoenix.Assertions.HaveInAssigns, [key, value]}

end