defmodule ESpec.Phoenix.Assertions.Content.HaveText do

  use ESpec.Assertions.Interface

  defp match(%Plug.Conn{resp_body: html}, val), do: match(html, val)

  defp match(html, val) do
    result = String.contains?(html, "#{val}") 
    {result, result}
  end
  
  defp success_message(%Plug.Conn{resp_body: html}, val, result, positive), do: success_message(html, val, result, positive)
  
  defp success_message(html, val, _result, positive) do
    to = if positive, do: "has", else: "doesn't have"
    "`#{html}` #{to} `#{val}`."
  end

  defp error_message(%Plug.Conn{resp_body: html}, val, result, positive), do: error_message(html, val, result, positive)

  defp error_message(html, val, result, positive) do
    to = if positive, do: "to", else: "to not"
    has = if result, do: "has", else: "has not"
    "Expected `#{html}` #{to} have `#{inspect val}`, but it #{has}."
  end

end
