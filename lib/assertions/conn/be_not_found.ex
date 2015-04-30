defmodule ESpec.Phoenix.Assertions.Conn.BeNotFound do

  use ESpec.Assertions.Interface

  defp match(conn, _value) do
    {conn.status == 404, conn.status}
  end

  defp success_message(conn, _value, _result, positive) do
    be = if positive, do: "is", else: "is not"
    "`#{inspect conn}` #{be} 'not found'."
  end  

  defp error_message(conn, _value, result, positive) do
    be = if positive, do: "be", else: "not to be"
    "Expected `#{inspect conn}` to #{be} 'not found', but the status is #{result}."
  end

end