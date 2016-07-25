defmodule ESpecPhoenixInitSpec do
  use ESpec

  @tmp_path Path.join(__DIR__, "tmp")

  before do
    Mix.shell(Mix.Shell.Process) # Get Mix output sent to the current process to avoid polluting tests.
    File.mkdir_p! @tmp_path

    File.cd! @tmp_path, fn -> Mix.Tasks.EspecPhoenix.Init.run([]) end
  end

  finally do: File.rm_rf! @tmp_path

  it "check files" do
    File.regular?(Path.join(@tmp_path, "spec/phoenix_helper.exs"))
  end

end
