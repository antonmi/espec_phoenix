defmodule ESpec.Phoenix.Assertions.Conn.Helpers do
  def have_http_status(value), do: {ESpec.Phoenix.Assertions.Conn.HaveHttpStatus, value}

  def be_successful, do: {ESpec.Phoenix.Assertions.Conn.BeSuccessful, []}
  def be_success, do: {ESpec.Phoenix.Assertions.Conn.BeSuccessful, []}
  def be_redirection, do: {ESpec.Phoenix.Assertions.Conn.BeRedirection, []}
  def be_redirect, do: {ESpec.Phoenix.Assertions.Conn.BeRedirection, []}
  def be_not_found, do: {ESpec.Phoenix.Assertions.Conn.BeNotFound, []}
  def be_missing, do: {ESpec.Phoenix.Assertions.Conn.BeNotFound, []}
  def be_server_error, do: {ESpec.Phoenix.Assertions.Conn.BeServerError, []}
  def be_error, do: {ESpec.Phoenix.Assertions.Conn.BeServerError, []}

  def redirect_to(value), do: { ESpec.Phoenix.Assertions.Conn.RedirectTo, value}

  def have_in_assigns(value), do: {ESpec.Phoenix.Assertions.Conn.HaveInAssigns, value}
  def have_in_flash(value), do: {ESpec.Phoenix.Assertions.Conn.HaveInFlash, value}

  def render_template(value), do: {ESpec.Phoenix.Assertions.Conn.RenderTemplate, value}
  def use_view(value), do: {ESpec.Phoenix.Assertions.Conn.UseView, value}
end
