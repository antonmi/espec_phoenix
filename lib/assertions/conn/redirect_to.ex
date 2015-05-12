defmodule ESpec.Phoenix.Assertions.Conn.RedirectTo do

  use ESpec.Assertions.Interface

  defp match(conn, location) do
    if conn.status >= 300 && conn.status < 400 do
      {_, l} = conn.resp_headers 
      |> Enum.find(fn({key, _val}) -> key == "location" end)
      {l == location, {:redirection, l}}
    else
      {false, {:not_redirection, conn.status}}
    end
  end

  defp success_message(conn, location, _result, positive) do
    redirect = if positive, do: "redirects", else: "does not redirect"
    "`#{inspect conn}` #{redirect} to #{location}."
  end  

  defp error_message(conn, location, {:not_redirection, result}, positive) do
    redirect = if positive, do: "redirect", else: "not to redirect"
    "Expected `#{inspect conn}` to #{redirect} to `#{location}`, but the status is `#{result}`."
  end

  defp error_message(conn, location, {:redirection, result}, positive) do
    redirect = if positive, do: "redirect", else: "not to redirect"
    "Expected `#{inspect conn}` to #{redirect} to `#{location}`, but it redirects to `#{result}`."
  end

end