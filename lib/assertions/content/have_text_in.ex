defmodule ESpec.Phoenix.Assertions.Content.HaveTextIn do

  use ESpec.Assertions.Interface

  defp match(%Plug.Conn{resp_body: html}, [selector, text]), do: match(html, [selector, text])

  defp match(html, [selector, text]) do
    selector_text = get_selector_text(html, selector)
    if selector_text do
      result = String.contains?(selector_text, "#{text}")
      {result, selector_text}
    else
      {false, :no_selector}
    end
  end

  defp get_selector_text(html, selector) do
    el = Floki.find(html, selector)
    case el do
      tuple when is_tuple(tuple)-> Floki.text(tuple)
      nil -> false
      [] -> false
      list when is_list(list) -> Floki.text(list)
    end
  end

  defp success_message(%Plug.Conn{resp_body: html}, [selector, text], result, positive), do: success_message(html, [selector, text], result, positive)

  defp success_message(html, [selector, text], result, positive) do
    has = if positive, do: "has", else: "has not"
    "`#{html}` #{has} text `#{text}` in selector `#{selector}`."
  end

  defp error_message(%Plug.Conn{resp_body: html}, [selector, text], result, positive), do: error_message(html, [selector, text], result, positive)

  defp error_message(html, [selector, text], :no_selector, positive) do
    have = if positive, do: "have", else: "not to have"
    "Expected `#{html}` to #{have} text `#{text}` in selector `#{selector}`, but there is no such selector."
  end

  defp error_message(html, [selector, text], result, positive) do
    have = if positive, do: "have", else: "not to have"
    "Expected `#{html}` to #{have} text `#{text}` in selector `#{selector}`, but the text is `#{result}`."
  end

end
