defmodule ESpec.Phoenix.Assertions.Content.HaveSelector do

  use ESpec.Assertions.Interface

  defp match(%Plug.Conn{resp_body: html}, selector), do: match(html, selector)

  defp match(html, selector) do
    el = Floki.find(html, selector)
    case el do
      tuple when is_tuple(tuple)-> {true, tuple}
      nil -> {false, false}
      [] -> {false, false}
      list when is_list(list) -> {true, list}
    end
  end

  defp success_message(%Plug.Conn{resp_body: html}, selector, result, positive), do: success_message(html, selector, result, positive)

  defp success_message(html, selector, result, positive) do
    has = if positive, do: "has", else: "has not"
    "`#{html}` #{has} selector `#{selector}`: `#{inspect result}`."
  end

  defp error_message(%Plug.Conn{resp_body: html}, selector, result, positive), do: error_message(html, selector, result, positive)

  defp error_message(html, selector, _result, positive) do
    have = if positive, do: "have", else: "not to have"
    but = if positive, do: "has not", else: "has"
    "Expected `#{html}` to #{have} selector `#{selector}`, but it #{but}."
  end

end
