defmodule ESpec.Phoenix.Extend do
  defmodule ModelHelpers do
    def model_helper_fun, do: :fun
  end

  defmodule ViewHelpers do
    def view_helper_fun, do: :fun
  end

  defmodule ControllerHelpers do
    def controller_helper_fun, do: :fun
  end

  defmodule ChannelHelpers do
    def channel_helper_fun, do: :fun
  end

  def model do
    quote do
      import ModelHelpers
    end
  end

  def controller do
    quote do
      import ControllerHelpers
    end
  end

  def view do
    quote do
      import ViewHelpers
    end
  end

  def channel do
    quote do
      import ChannelHelpers
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
