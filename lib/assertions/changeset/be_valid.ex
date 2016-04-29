defmodule ESpec.Phoenix.Assertions.Changeset.BeValid do
  use ESpec.Assertions.Interface

  defp match(changeset, _value) do
    {changeset.valid?, changeset.valid?}
  end

  defp success_message(changeset, _value, _result, positive) do
    be = if positive, do: "is", else: "is not"
    "`#{inspect changeset}` #{be} valid."
  end  

  defp error_message(changeset, _value, _result, positive) do
    be = if positive, do: "be", else: "not to be"
    but = if positive, do: "it is not", else: "it is"
    "Expected `#{inspect changeset}` to #{be} valid, but #{but}."
  end
end