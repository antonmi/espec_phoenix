defmodule ESpec.Phoenix.Assertions.Helpers do

  def have_http_status(value), do: {ESpec.Phoenix.Assertions.Conn.HaveHttpStatus, value}
  def be_successfull, do: {ESpec.Phoenix.Assertions.Conn.BeSuccessfull, []}
  
  def have_in_assigns(key), do: {ESpec.Phoenix.Assertions.Conn.HaveInAssigns, [key]}
  def have_in_assigns(key, value), do: {ESpec.Phoenix.Assertions.Conn.HaveInAssigns, [key, value]}
  
  def have_in_flash(key), do: {ESpec.Phoenix.Assertions.Conn.HaveInFlash, [key]}
  def have_in_flash(key, value), do: {ESpec.Phoenix.Assertions.Conn.HaveInFlash, [key, value]}

end