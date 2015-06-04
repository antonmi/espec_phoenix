defmodule ESpec.Phoenix.Assertions.Conn.RenderTemplate do

  use ESpec.Assertions.Interface

  defp match(conn, template) do
    {conn.private[:phoenix_template] == template, conn.private[:phoenix_template]}
  end

  defp success_message(conn, template, _result, positive) do
    render = if positive, do: "renders", else: "does not render"
    "`#{inspect conn}` #{render} #{template}."
  end  

  defp error_message(conn, template, result, positive) do
    render = if positive, do: "render", else: "not to render"
    "Expected `#{inspect conn}` to #{render} `#{template}`, but it renders `#{result}`."
  end

end