defmodule ESpec.Phoenix.Views.Helpers do

  defmacro __using__(args) do
    quote do

      def render(template, assigns) do
        assigns = Keyword.put_new(assigns, :conn, conn())
        Phoenix.View.render_to_string @view, template, assigns
      end
      
    end
  end


end