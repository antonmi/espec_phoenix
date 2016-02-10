defmodule ESpec.Phoenix.Assertions.Changeset.HaveErrors do

  use ESpec.Assertions.Interface

  defp match(changeset, list) when is_list list do
    result = if Keyword.keyword?(list) do
      Enum.all?(list, &Enum.member?(changeset.errors, &1))
    else
      keys = Keyword.keys(changeset.errors)
      Enum.all?(list, &Enum.member?(keys, &1))
    end
    {result, result}
  end

  defp match(changeset, value) do
    result = Enum.member?(Keyword.keys(changeset.errors), value)
    {result, result}
  end

  defp success_message(changeset, value, _result, positive) do
    has = if positive, do: "has", else: "has not"
    "`#{inspect changeset}` #{has} errors `#{inspect value}`."
  end

  defp error_message(changeset, value, _result, positive) do
    have = if positive, do: "have", else: "not to have"
    but = if positive, do: "it has not", else: "it has"
    "Expected `#{inspect changeset}` to #{have} errors `#{inspect value}`, but #{but}."
  end

end
