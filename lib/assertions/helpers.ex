defmodule ESpec.Phoenix.Assertions.Helpers do

  def have_http_status(value), do: {ESpec.Phoenix.Assertions.HaveHttpStatus, value}
  def be_successfull, do: {ESpec.Phoenix.Assertions.BeSuccessfull, []}


end