defmodule ESpec.Phoenix.Assertions.Conn.BeRedirection do

  use ESpec.Assertions.Interface

  defp match(conn, _value) do
    {conn.status >= 300 && conn.status < 400, conn.status}
  end

  defp success_message(conn, _value, _result, positive) do
    be = if positive, do: "is", else: "is not"
    "`#{inspect conn}` #{be} redirection."
  end  

  defp error_message(conn, _value, result, positive) do
    be = if positive, do: "be", else: "not to be"
    "Expected `#{inspect conn}` to #{be} redirection, but the status is #{result}."
  end

end