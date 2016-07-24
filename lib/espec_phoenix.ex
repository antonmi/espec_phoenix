defmodule ESpec.Phoenix do
  defmacro __using__(args) do
    cond do
      Keyword.has_key?(args, :model) ->
        quote do
          use ESpec, unquote(args)
          @view Keyword.get(unquote(args), :model)

          use ESpec.Phoenix.ModelHelpers

          use ESpec.Phoenix.Extend, :model
        end

      Keyword.has_key?(args, :controller) ->
        quote do
          use ESpec, unquote(args)
          @controller Keyword.get(unquote(args), :controller)

          use ESpec.Phoenix.ModelHelpers
          use ESpec.Phoenix.ControllerHelpers

          use ESpec.Phoenix.Extend, :controller
        end

      Keyword.has_key?(args, :view) ->
        quote do
          use ESpec, unquote(args)
          @view Keyword.get(unquote(args), :view)

          # use ESpec.Phoenix.ModelHelpers
          use ESpec.Phoenix.ControllerHelpers

          import Phoenix.View
          use ESpec.Phoenix.Extend, :view
        end


      true -> :ok
    end
  end

  defmodule ModelHelpers do
    defmacro __using__(_args) do
      quote do
        import Ecto
        import Ecto.Changeset, except: [change: 1, change: 2]
        import Ecto.Query
      end
    end
  end

  defmodule ControllerHelpers do
    defmacro __using__(_args) do
      quote do
        import Plug.Conn
        import Phoenix.ConnTest, except: [conn: 0]

        def init_conn, do: Phoenix.ConnTest.build_conn()
      end
    end
  end
end
