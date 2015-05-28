defmodule ESpec.Phoenix.Assertions.Conn.UseView do

  use ESpec.Assertions.Interface

  defp match(conn, view) do
    {conn.private[:phoenix_view] == view, view}
  end

  defp success_message(conn, view, _result, positive) do
    use_view = if positive, do: "uses", else: "does not use"
    "`#{inspect conn}` #{use_view} #{view}."
  end  

  defp error_message(conn, view, result, positive) do
    use_view = if positive, do: "use", else: "not to use"
    "Expected `#{inspect conn}` to #{use_view} `#{view}`, but it uses `#{result}`."
  end

end