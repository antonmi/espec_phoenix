defmodule ESpec.Phoenix.Extend do
  def model do
    quote do
      alias Rumbl.Repo
      import Rumbl.TestHelpers

      def errors_on(struct, data) do
        struct.__struct__.changeset(struct, data)
        |> Ecto.Changeset.traverse_errors(&Rumbl.ErrorHelpers.translate_error/1)
        |> Enum.flat_map(fn {key, errors} -> for msg <- errors, do: {key, msg} end)
      end
    end
  end

  def controller do
    quote do
      alias Rumbl.Repo

      import Rumbl.Router.Helpers
      import Rumbl.TestHelpers

      @endpoint Rumbl.Endpoint
    end
  end

  def view do
    quote do
      import Rumbl.Router.Helpers
    end
  end

  def channel do
    quote do
      alias Rumbl.Repo

      import Rumbl.TestHelpers

      @endpoint Rumbl.Endpoint
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
