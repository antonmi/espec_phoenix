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
    create_espec_files()

    app = Mix.Phoenix.base()
    create_espec_phoenix_files(app)
    patch_espec_config()
  end

  defp create_espec_files do
    create_directory(@spec_folder)
    create_file(Path.join(@spec_folder, @espec_helper), spec_helper_template(nil))
  end

  defp create_espec_phoenix_files(app) do
    create_file(Path.join(@spec_folder, @phoenix_helper), phoenix_helper_template(app: app))

    create_file(
      Path.join(@spec_folder, @espec_phoenix_extend),
      espec_phoenix_extend_template(app: app)
    )
  end

  defp patch_espec_config do
    append_to(Path.join(@spec_folder, @espec_helper), espec_helper_patch_text())
  end

  defp append_to(filepath, contents) do
    File.write!(filepath, File.read!(filepath) <> contents)
  end

  embed_text(:espec_helper_patch, """
  Code.require_file("spec/phoenix_helper.exs")
  """)

  embed_template(:spec_helper, """
  ESpec.configure fn(config) ->
    config.before fn(tags) ->
      {:shared, hello: :world, tags: tags}
    end

    config.finally fn(_shared) ->
      :ok
    end
  end
  """)

  embed_template(:shared_spec_example, """
  defmodule ExampleSharedSpec do
    use ESpec, shared: true

    # This shared spec will always be included!
  end
  """)

  embed_template(:phoenix_helper, """
  Code.require_file("spec/espec_phoenix_extend.ex")

  Ecto.Adapters.SQL.Sandbox.mode(<%= @app %>.Repo, :manual)
  """)

  embed_template(:espec_phoenix_extend, """
  defmodule ESpec.Phoenix.Extend do
    def model do
      quote do
        alias <%= @app %>.Repo
      end
    end

    def controller do
      quote do
        alias <%= @app %>
        import <%= @app %>Web.Router.Helpers

        @endpoint <%= @app %>Web.Endpoint
      end
    end

    def view do
      quote do
        import <%= @app %>Web.Router.Helpers
      end
    end

    def channel do
      quote do
        alias <%= @app %>.Repo

        @endpoint <%= @app %>Web.Endpoint
      end
    end

    def live_view do
      quote do
        alias <%= @app %>
        import <%= @app %>Web.Router.Helpers

        @endpoint <%= @app %>Web.Endpoint
      end
    end

    defmacro __using__(which) when is_atom(which) do
      apply(__MODULE__, which, [])
    end
  end
  """)
end
