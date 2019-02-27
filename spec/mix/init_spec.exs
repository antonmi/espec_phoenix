defmodule ESpecPhoenixInitSpec do
  use ESpec

  @tmp_path Path.join(__DIR__, "tmp")

  before do
    Mix.shell(Mix.Shell.Process) # Get Mix output sent to the current process to avoid polluting tests.
    File.mkdir_p! @tmp_path

    File.cd! @tmp_path, fn -> Mix.Tasks.EspecPhoenix.Init.run([]) end
  end

  finally do: File.rm_rf! @tmp_path

  before do
    {:ok, content} = File.read(Path.join(@tmp_path, file()))
    {:shared, content: content}
  end

  let :content, do: shared[:content]

  describe "phoenix_helper" do
    let :file, do: "spec/phoenix_helper.exs"

    it "check files" do
      File.regular?(Path.join(@tmp_path, file())) |> should(be_true())
    end

    it "requires espec_phoenix_extend" do
      expect(content())
      |> to( have "Code.require_file(\"spec/espec_phoenix_extend.ex\")")
    end

    it "sets sandbox moded" do
      expect(content())
      |> to( have "Ecto.Adapters.SQL.Sandbox.mode(EspecPhoenix.Repo, :manual)")
    end
  end

  describe "espec_phoenix_extend" do
    let :file, do: "spec/espec_phoenix_extend.ex"

    before do: Code.require_file(file())

    it "check files" do
      File.regular?(Path.join(@tmp_path, file())) |> should(be_true())
    end

    it "defines model section" do
      expect(content())
      |> to(have "def model do")
    end

    it "defines controller section" do
      expect(content())
      |> to(have "def controller do")
    end

    it "defines view section" do
      expect(content())
      |> to(have "def view do")
    end

    it "defines channel section" do
      expect(content())
      |> to(have "def channel do")
    end

    it "substitutes app" do
      expect(content())
      |> to(have "alias EspecPhoenix.Repo")
    end

    it "sets @endpoint" do
      expect(content())
      |> to(have "@endpoint EspecPhoenixWeb.Endpoint")
    end
  end
end
