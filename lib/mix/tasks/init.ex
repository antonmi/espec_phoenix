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
  @espec_helper "spec_helper.exs"
  @phoenix_helper "phoenix_helper.exs"
  @espec_phoenix_extend "espec_phoenix_extend.ex"

  def run(_args) do
    app = Mix.Phoenix.base
    create_files(app)
    patch_espec_config
  end

  defp create_files(app) do
    create_file(Path.join(@spec_folder, @phoenix_helper), phoenix_helper_template(app: app))
    create_file(Path.join(@spec_folder, @espec_phoenix_extend), espec_phoenix_extend_template(app: app))
  end

  defp patch_espec_config do
    append_to Path.join(@spec_folder, @espec_helper), espec_helper_patch_text
  end

  defp append_to(filepath, contents) do
    File.write!(filepath, File.read!(filepath) <> contents)
  end

  embed_text :espec_helper_patch, """
  Code.require_file("spec/phoenix_helper.exs")
  """

  embed_template :phoenix_helper, """
  Code.require_file("spec/espec_phoenix_extend.ex")

  Ecto.Adapters.SQL.Sandbox.mode(<%= @app %>.Repo, :manual)
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

        @endpoint <%= @app %>.Endpoint
      end
    end

    def view do
      quote do
        import <%= @app %>.Router.Helpers
      end
    end

    def channel do
      quote do
        alias <%= @app %>.Repo

        @endpoint <%= @app %>.Endpoint
      end
    end

    defmacro __using__(which) when is_atom(which) do
      apply(__MODULE__, which, [])
    end
  end
  """
end
