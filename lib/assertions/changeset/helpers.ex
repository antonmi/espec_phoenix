defmodule ESpec.Phoenix.Assertions.Changeset.Helpers do
  def be_valid, do: {ESpec.Phoenix.Assertions.Changeset.BeValid, []}
  def have_errors(value), do: {ESpec.Phoenix.Assertions.Changeset.HaveErrors, value}
end
