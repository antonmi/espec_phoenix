defmodule ESpec.Phoenix.Assertions.BeSuccessfull do

	use ESpec.Assertions.Interface

  defp match(response, _value) do
    {response.status >= 200 && response.status < 300, response.status}
  end

  defp success_message(response, _value, _result, positive) do
    be = if positive, do: "is", else: "is not"
    "`#{inspect response}` #{be} successfull."
  end  

  defp error_message(response, _value, result, positive) do
    be = if positive, do: "be", else: "not to be"
    "Expected `#{inspect response}` to #{be} suceessfull, but the status is #{result}."
  end

end