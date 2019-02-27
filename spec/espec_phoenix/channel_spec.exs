defmodule ChannelSpec do
  use ESpec.Phoenix, channel: SomeChannel

  it "sets @channel" do
    expect(@channel) |> to(eq SomeChannel)
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

    context "imports functions from Phoenix.ChannelTest" do
      before do
        allow(Phoenix.ChannelTest) |> to(accept(:subscribe_and_join, fn(a, b) -> a + b end))
      end

      it "call Phoenix.ChannelTest function" do
        subscribe_and_join(2, 2) |> should(eq 4)
      end
    end
  end

  describe "imports from ESpec.Phoenix.Extend" do
    it "calls function from ChannelHelpers" do
      channel_helper_fun() |> should(eq :fun)
    end
  end
end
