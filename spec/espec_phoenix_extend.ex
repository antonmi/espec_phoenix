defmodule ESpec.Phoenix.Extend do
  defmodule ModelHelpers do
    def module_helper_fun, do: :fun
  end

  def model do
    quote do
      import ModelHelpers
    end
  end

  def controller do
    quote do

    end
  end

  def view do
    quote do
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
