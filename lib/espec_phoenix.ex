defmodule ESpec.Phoenix do
  defmacro __using__(args) do
    use_async = case Keyword.has_key?( args, :async ) do
                  true -> Keyword.get( args, :async )
                  _    -> false
                end

    cond do
      Keyword.has_key?(args, :model) ->
        quote do
          use ESpec, async: unquote(use_async)
          @model Keyword.get(unquote(args), :model)

          import Ecto.Model
          import Ecto.Query, only: [from: 2]

          import ESpec.Phoenix.Assertions.Changeset.Helpers

          use ESpec.Phoenix.Extend, :model
        end

      Keyword.has_key?(args, :controller) ->
        quote do
          use ESpec, async: unquote(use_async)
          @controller Keyword.get(unquote(args), :controller)

          use Phoenix.ConnTest

          use ESpec.Phoenix.Controllers.Helpers
          import ESpec.Phoenix.Assertions.Conn.Helpers

          use ESpec.Phoenix.Extend, :controller
        end

      Keyword.has_key?(args, :request) ->
        quote do
          use ESpec, async: unquote(use_async)
          @endpoint Keyword.get(unquote(args), :request)

          import ESpec.Phoenix.Assertions.Content.Helpers
          use Phoenix.ConnTest
          import ESpec.Phoenix.Assertions.Conn.Helpers

          import Ecto.Model
          import Ecto.Query, only: [from: 2]

          use ESpec.Phoenix.Extend, :request
        end

      Keyword.has_key?(args, :router) ->
        quote do
          use ESpec, async: unquote(use_async)
          @router Keyword.get(unquote(args), :router)
          use ESpec.Phoenix.Extend, :router
        end

      Keyword.has_key?(args, :view) ->
        quote do
          use ESpec, async: unquote(use_async)
          @view Keyword.get(unquote(args), :view)

          use Phoenix.ConnTest

          import ESpec.Phoenix.Assertions.Content.Helpers
          use ESpec.Phoenix.Views.Helpers

          use ESpec.Phoenix.Extend, :view
        end

        true -> :ok
    end
  end
end
