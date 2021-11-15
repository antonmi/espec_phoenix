defmodule ESpec.Phoenix do
  @moduledoc """
  ESpec Phoenix basic module. Imports core ESpec plus some Phoenix-related components.
  One should `use` the module in spec modules.
  """

  defmacro __using__(args) do
    cond do
      Keyword.has_key?(args, :model) ->
        quote do
          use ESpec, unquote(args)
          @model Keyword.get(unquote(args), :model)

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

          use ESpec.Phoenix.ControllerHelpers

          import Phoenix.View
          use ESpec.Phoenix.Extend, :view
        end

      Keyword.has_key?(args, :channel) ->
        quote do
          use ESpec, unquote(args)
          @channel Keyword.get(unquote(args), :channel)

          import Phoenix.ChannelTest
          use ESpec.Phoenix.ModelHelpers

          use ESpec.Phoenix.Extend, :channel
        end

      Keyword.has_key?(args, :live_view) ->
        quote do
          use ESpec, unquote(args)
          @live_view Keyword.get(unquote(args), :live_view)

          import Phoenix.LiveViewTest
          use ESpec.Phoenix.ModelHelpers
          use ESpec.Phoenix.LiveViewHelpers, unquote(args)
          use ESpec.Phoenix.Extend, :live_view
        end

      true ->
        quote do
          use ESpec, unquote(args)
        end
    end
  end

  defmodule ModelHelpers do
    @moduledoc false

    defmacro __using__(_args) do
      if Code.ensure_loaded?(Ecto) do
        quote do
          import Ecto
          import Ecto.Changeset, except: [change: 1, change: 2]
          import Ecto.Query
        end
      end
    end
  end

  defmodule ControllerHelpers do
    @moduledoc false

    defmacro __using__(_args) do
      quote do
        import Plug.Conn
        import Phoenix.ConnTest, except: [conn: 0, build_conn: 0]

        def build_conn, do: Phoenix.ConnTest.build_conn()
      end
    end
  end

  defmodule LiveViewHelpers do
    @moduledoc false

    defmacro __using__(args) do
      quote do
        import Plug.Conn
        import Phoenix.ConnTest, except: [conn: 0, build_conn: 0]

        def live_conn do
          ExUnit.OnExitHandler.start_link([])
          ExUnit.OnExitHandler.register(Keyword.get(unquote(args), :pid))
          Phoenix.ConnTest.build_conn()
        end
      end
    end
  end
end
