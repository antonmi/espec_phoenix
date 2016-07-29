defmodule Mix.Tasks.EspecPhoenix.Init do
  use Mix.Task
  import Mix.Generator

  @shortdoc "Create espec_phoenix folders and files"

  @moduledoc """
  Creates `spec/phoenix_helper.exs` and `spec/espec_phoenix_extend.ex`.

  This task creates the following files:

    * `spec/phoenix_helper.exs`
    * `spec/espec_phoenix_extend.ex`

  """

  @spec_folder "spec"
  @phoenix_helper "phoenix_helper.exs"
  @espec_phoenix_extend "espec_phoenix_extend.ex"

  def run(_args) do
    app = Mix.Phoenix.base
    create_files(app)
  end

  defp create_files(app) do
    create_file(Path.join(@spec_folder, @phoenix_helper), phoenix_helper_template(nil))
    create_file(Path.join(@spec_folder, @espec_phoenix_extend), espec_phoenix_extend_template(app: app))
  end

  embed_template :phoenix_helper, """
  Code.require_file("spec/espec_phoenix_extend.ex")

  Ecto.Adapters.SQL.Sandbox.mode(Rumbl.Repo, :manual)
  """

  embed_template :espec_phoenix_extend, """
  defmodule ESpec.Phoenix.Extend do
    def model do
      quote do
        alias <%= @app %>.Repo
      end
    end

    def controller do
      quote do
        alias <%= @app %>
        import <%= @app %>.Router.Helpers

        # The default endpoint for testing
        @endpoint <%= @app %>.Endpoint
      end
    end

    def view do
      quote do
        import <%= @app %>.Router.Helpers
      end
    end

    defmacro __using__(which) when is_atom(which) do
      apply(__MODULE__, which, [])
    end
  end
  """
end
