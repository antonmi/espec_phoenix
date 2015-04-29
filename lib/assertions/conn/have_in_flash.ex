defmodule ESpec.Phoenix.Assertions.Conn.HaveInFlash do

  use ESpec.Assertions.Interface

	defp match(conn, [key]) do
    result = Map.has_key?(flash(conn), key)
    {result, result}
  end

  defp match(conn, [key, value]) do
    if Map.has_key?(flash(conn), key) do
      {flash(conn)[key] == value, flash(conn)[key]}
    else
      {false, false}
    end
  end

  defp flash(conn), do: conn.private[:phoenix_flash]

  defp success_message(conn, [key], _result, positive) do
    has = if positive, do: "has", else: "has not"
    "`#{inspect conn}` #{has} `#{key}` in the flash."
  end  

  defp success_message(conn, [key, value], _result, positive) do
    has = if positive, do: "has", else: "has not"
    "`#{inspect conn}` #{has} flash `#{key}` => `#{inspect value}`."
  end  

  defp error_message(conn, [key], result, positive) do
    have = if positive, do: "to have", else: "not to have"
    but = if positive, do: "hasn't", else: "has"
    "Expected `#{inspect conn}` #{have} `#{key}` in the flash, but #{but}."
  end

  defp error_message(conn, [key, value], false, positive) do
    have = if positive, do: "to have", else: "not to have"
    but = if positive, do: "hasn't the key", else: "has the key"
    "Expected `#{inspect conn}` #{have} `#{key}` => `#{value}` in the flash, but #{but}."
  end

  defp error_message(conn, [key, value], result, positive) do
    have = if positive, do: "to have", else: "not to have"
    "Expected `#{inspect conn}` #{have} `#{key}` => `#{value}` in the flash, but it has `#{key}` => `#{inspect result}`."
  end

end