defmodule ViewSpec do
  use ESpec.Phoenix, view: SomeView

  it "sets @view" do
    expect(@view) |> to(eq(SomeView))
  end

  describe "imports" do
    context "imports functions from Phoenix.View" do
      before do
        allow(Phoenix.View) |> to(accept(:render, fn a, b, c -> a + b + c end))
      end

      it "call Ecto function" do
        render(1, 2, 3) |> should(eq(6))
      end
    end

    context "imports functions from Phoenix.ConnTest" do
      before do
        allow(Phoenix.ConnTest) |> to(accept(:get_flash, fn a -> a end))
      end

      it "call Phoenix.ConnTest function" do
        get_flash(:test) |> should(eq(:test))
      end

      context "build_conn/0" do
        before do
          allow(Phoenix.ConnTest) |> to(accept(:build_conn, fn -> :ok end))
        end

        it "call Phoenix.ConnTest.build_conn" do
          build_conn() |> should(eq(:ok))
        end
      end
    end

    context "imports functions from Plug.Conn" do
      before do
        allow(Plug.Conn) |> to(accept(:clear_session, fn a -> a end))
      end

      it "call Plug.Conn function" do
        clear_session(:test) |> should(eq(:test))
      end
    end
  end

  describe "imports from ESpec.Phoenix.Extend" do
    it "calls function from ModelHelpers" do
      view_helper_fun() |> should(eq(:fun))
    end
  end
end
