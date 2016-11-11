defmodule ViewSpec do
  use ESpec.Phoenix, view: SomeView

  it "sets @view" do
    expect(@view) |> to(eq SomeView)
  end

  describe "imports" do
    context "imports functions from Phoenix.View" do
      before do
        allow(Phoenix.View).to accept(:render, fn(a, b, c) -> a+b+c end)
      end

      it "call Ecto function" do
        expect(render(1,2,3)).to eq(6)
      end
    end

    context "imports functions from Phoenix.ConnTest" do
      before do
        allow(Phoenix.ConnTest).to accept(:get_flash, fn(a) -> a end)
      end

      it "call Phoenix.ConnTest function" do
        expect(get_flash(:test)).to eq(:test)
      end

      context "build_conn/0" do
        before do
          allow(Phoenix.ConnTest).to accept(:build_conn, fn -> :ok end)
        end

        it "call Phoenix.ConnTest.build_conn" do
          expect(build_conn()).to eq(:ok)
        end
      end
    end

    context "imports functions from Plug.Conn" do
      before do
        allow(Plug.Conn).to accept(:clear_session, fn(a) -> a end)
      end

      it "call Plug.Conn function" do
        expect(clear_session(:test)).to eq(:test)
      end
    end
  end

  describe "imports from ESpec.Phoenix.Extend" do
    it "calls function from ModelHelpers" do
      expect(view_helper_fun()).to eq(:fun)
    end
  end
end
