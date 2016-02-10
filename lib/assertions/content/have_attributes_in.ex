defmodule ESpec.Phoenix.Assertions.Content.HaveAttributesIn do

  use ESpec.Assertions.Interface

  defp match(%Plug.Conn{resp_body: html}, [selector, list]), do: match(html, [selector, list])

  defp match(html, [selector, list]) when is_list list do
    el = find_element(html, selector)
    if el do
      result = if Keyword.keyword?(list) do
        list = Enum.map(list, fn{k, v} -> {"#{k}", v} end)
        Enum.all?(list, fn{attr, value} ->
          Enum.member?(Floki.attribute(el, "#{attr}"), "#{value}")
        end)
      else
        Enum.all?(list, fn(attr) ->
          !Enum.empty?(Floki.attribute(el, "#{attr}"))
        end)
      end
      {result, result}
    else
      {false, :no_selector}
    end
  end

  defp match(html, [selector, value]) do
    el = find_element(html, selector)
    if el do
      result = !Enum.empty?(Floki.attribute(el, "#{value}"))
      {result, result}
    else
      {false, :no_selector}
    end
  end

  defp find_element(html, selector) do
    el = Floki.find(html, selector)
    case el do
      nil -> false
      [] -> false
      el -> el
    end
  end

  defp success_message(%Plug.Conn{resp_body: html}, [selector, value], result, positive), do: success_message(html, [selector, value], result, positive)

  defp success_message(html, [selector, value], _result, positive) do
    has = if positive, do: "has", else: "has not"
    "`#{html}` #{has} attributes `#{inspect value}` in selector `#{selector}`."
  end

  defp error_message(html, [selector, value], :no_selector, positive) do
    have = if positive, do: "have", else: "not to have"
    "Expected `#{html}` to #{have} attributes `#{inspect value}` in selector `#{selector}`, but there is no such selector."
  end

  defp error_message(%Plug.Conn{resp_body: html}, [selector, value], result, positive), do: error_message(html, [selector, value], result, positive)

  defp error_message(html, [selector, value], _result, positive) do
    have = if positive, do: "have", else: "not to have"
    but = if positive, do: "it has not", else: "it has"
    "Expected `#{html}` to #{have} attributes `#{inspect value}` in selector `#{selector}`, but #{but}."
  end

end
