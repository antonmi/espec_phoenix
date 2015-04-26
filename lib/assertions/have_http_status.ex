defmodule ESpec.Phoenix.Assertions.HaveHttpStatus do

	use ESpec.Assertions.Interface

  defp match(response, value) do
    {response.status == value, response.status}
  end

  defp success_message(response, value, _result, positive) do
    to = if positive, do: "has", else: "has not"
    "`#{inspect response}` #{to} status: #{value}."
  end  

  defp error_message(response, value, result, positive) do
    to = if positive, do: "have", else: "not to have"
    "Expected `#{inspect response}` to #{to} status `#{value}`, but the status is #{result}."
  end

end