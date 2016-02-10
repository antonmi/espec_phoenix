defmodule ESpec.Phoenix.Assertions.Conn.HaveInFlash do

  use ESpec.Assertions.Interface

  defp match(conn, list) when is_list list do
    result = if Keyword.keyword?(list) do
      list = Enum.map(list, fn{k, v} -> {"#{k}", v} end)
      Enum.all?(list, &Enum.member?(flash(conn), &1))
    else
      keys = Map.keys(flash(conn))
      Enum.all?(list, &Enum.member?(keys, "#{&1}"))
    end
    {result, result}
  end

  defp match(conn, value) do
    result = Enum.member?(Map.keys(flash(conn)), "#{value}")
    {result, result}
  end

  defp flash(conn), do: conn.private[:phoenix_flash]

  defp success_message(conn, value, _result, positive) do
    has = if positive, do: "has", else: "has not"
    "`#{inspect conn}` #{has} flash `#{inspect value}`."
  end

  defp error_message(conn, value, _result, positive) do
    have = if positive, do: "have", else: "not to have"
    but = if positive, do: "it has not", else: "it has"
    "Expected `#{inspect conn}` to #{have} flash `#{inspect value}`, but #{but}."
  end

end
