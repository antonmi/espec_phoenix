defmodule ESpec.Phoenix.Assertions.HaveHttpStatus do

	use ESpec.Assertions.Interface

  defp match(conn, value) do
    {conn.status == value, conn.status}
  end

  defp success_message(conn, value, _result, positive) do
    to = if positive, do: "has", else: "has not"
    "`#{inspect conn}` #{to} status: #{value}."
  end  

  defp error_message(conn, value, result, positive) do
    to = if positive, do: "have", else: "not to have"
    "Expected `#{inspect conn}` to #{to} status `#{value}`, but the status is #{result}."
  end

end