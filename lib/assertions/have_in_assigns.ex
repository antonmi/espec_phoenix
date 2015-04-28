defmodule ESpec.Phoenix.Assertions.HaveInAssigns do

	use ESpec.Assertions.Interface

	defp match(conn, [key]) do
  	result = Map.has_key?(conn.assigns, key)
    {result, result}
  end

  defp match(conn, [key, value]) do
  	if Map.has_key?(conn.assigns, key) do
  		{conn.assigns[key] == value, conn.assigns[key]}
  	else
    	{false, false}
  	end
  end

  defp success_message(conn, [key], _result, positive) do
    has = if positive, do: "has", else: "has not"
    "`#{inspect conn}` #{has} `#{key}` in the assigns."
  end  

  defp success_message(conn, [key, value], _result, positive) do
    has = if positive, do: "has", else: "has not"
    "`#{inspect conn}` #{has} assgins `#{key}` => `#{value}`."
  end  

  defp error_message(conn, [key], result, positive) do
    have = if positive, do: "to have", else: "not to have"
    but = if positive, do: "hasn't", else: "has"
    "Expected `#{inspect conn}` #{have} `#{key}` in the assigns, but #{but}."
  end

  defp error_message(conn, [key, value], false, positive) do
    have = if positive, do: "to have", else: "not to have"
    but = if positive, do: "hasn't the key", else: "has the key"
    "Expected `#{inspect conn}` #{have} `#{key}` => `#{value}` in the assigns, but #{but}."
  end

  defp error_message(conn, [key, value], result, positive) do
  	have = if positive, do: "to have", else: "not to have"
    "Expected `#{inspect conn}` #{have} `#{key}` => `#{value}` in the assigns, but it has `#{key}` => `#{result}`."
  end


end