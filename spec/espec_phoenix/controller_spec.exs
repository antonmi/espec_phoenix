defmodule ControllerSpec do
  use ESpec.Phoenix, controller: SomeController

  it "sets @model" do
    expect(@controller) |> to(eq SomeController)
  end

  describe "imports" do
    context "imports functions from Ecto" do
      before do
        allow(Ecto) |> to(accept(:primary_key, fn(a) -> a end))
      end

      it "call Ecto function" do
        primary_key(:test) |> should(eq :test)
      end
    end

    context "imports functions from Ecto.Changeset" do
      before do
        allow(Ecto.Changeset) |> to(accept(:merge, fn(a, b) -> a + b end))
      end

      it "call Ecto.Changeset function" do
        merge(2, 2) |> should(eq 4)
      end

      context "it does not import change/1 and change/2" do
        before do
          allow(Ecto.Changeset) |> to(accept(:change, fn(_a) -> :ok end))
          allow(Ecto.Changeset) |> to(accept(:change, fn(_a, _b) -> :ok end))
        end

        it "call ESpec function" do
          change(fn -> :ok end) |> should_not(eq :ok)
          change(fn -> :ok end, 2) |> should_not(eq :ok)
        end
      end
    end

    context "imports functions from Ecto.Query" do
      before do
        allow(Ecto.Query) |> to(accept(:exclude, fn(a, b) -> a + b end))
      end

      it "call Ecto.Query function" do
        exclude(2, 2) |> should(eq 4)
      end
    end

    context "imports functions from Phoenix.ConnTest" do
      before do
        allow(Phoenix.ConnTest) |> to(accept(:get_flash, fn(a) -> a end))
      end

      it "call Phoenix.ConnTest function" do
        get_flash(:test) |> should(eq :test)
      end

      context "build_conn/0" do
        before do
          allow(Phoenix.ConnTest) |> to(accept(:build_conn, fn -> :ok end))
        end

        it "call Phoenix.ConnTest.build_conn" do
          build_conn() |> should(eq :ok)
        end
      end
    end

    context "imports functions from Plug.Conn" do
      before do
        allow(Plug.Conn) |> to(accept(:clear_session, fn(a) -> a end))
      end

      it "call Plug.Conn function" do
        clear_session(:test) |> to(eq :test)
      end
    end
  end

  describe "imports from ESpec.Phoenix.Extend" do
    it "calls function from ModelHelpers" do
      controller_helper_fun() |> to(eq :fun)
    end
  end
end
