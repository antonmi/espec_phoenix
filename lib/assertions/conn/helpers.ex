defmodule ESpec.Phoenix.Assertions.Helpers do

  def have_http_status(value), do: {ESpec.Phoenix.Assertions.Conn.HaveHttpStatus, value}
 
  def be_successfull, do: {ESpec.Phoenix.Assertions.Conn.BeSuccessfull, []}
  def be_success, do: {ESpec.Phoenix.Assertions.Conn.BeSuccessfull, []}  
  def be_redirection, do: {ESpec.Phoenix.Assertions.Conn.BeRedirection, []}
  def be_redirect, do: {ESpec.Phoenix.Assertions.Conn.BeRedirection, []}
  def be_not_found, do: {ESpec.Phoenix.Assertions.Conn.BeNotFound, []}
  def be_missing, do: {ESpec.Phoenix.Assertions.Conn.BeNotFound, []}
  def be_server_error, do: {ESpec.Phoenix.Assertions.Conn.BeServerError, []}
  def be_error, do: {ESpec.Phoenix.Assertions.Conn.BeServerError, []}

  def redirect_to(value), do: { ESpec.Phoenix.Assertions.Conn.RedirectTo, value}

  def have_in_assigns(key), do: {ESpec.Phoenix.Assertions.Conn.HaveInAssigns, [key]}
  def have_in_assigns(key, value), do: {ESpec.Phoenix.Assertions.Conn.HaveInAssigns, [key, value]}
  
  def have_in_flash(key), do: {ESpec.Phoenix.Assertions.Conn.HaveInFlash, [key]}
  def have_in_flash(key, value), do: {ESpec.Phoenix.Assertions.Conn.HaveInFlash, [key, value]}

end