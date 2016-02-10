defmodule ESpec.Phoenix.Assertions.Conn.HaveInAssigns do
  use ESpec.Assertions.Interface

  defp match(conn, list) when is_list(list) do
    result = if Keyword.keyword?(list) do
      Enum.all?(list, &Enum.member?(conn.assigns, &1))
    else
      keys = Map.keys(conn.assigns)
      Enum.all?(list, &Enum.member?(keys, &1))
    end
    {result, result}
  end

  defp match(conn, value) do
    result = Enum.member?(Map.keys(conn.assigns), value)
    {result, result}
  end

  defp success_message(conn, value, _result, positive) do
    has = if positive, do: "has", else: "has not"
    "`#{inspect conn}` #{has} assigns `#{inspect value}`."
  end

  defp error_message(conn, value, _result, positive) do
    have = if positive, do: "have", else: "not to have"
    but = if positive, do: "it has not", else: "it has"
    "Expected `#{inspect conn}` to #{have} assigns `#{inspect value}`, but #{but}."
  end
end
