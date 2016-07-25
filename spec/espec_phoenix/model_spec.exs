defmodule ModelSpec do
  use ESpec.Phoenix, model: SomeModel

  it "sets @model" do
    expect(@model) |> to(eq SomeModel)
  end

  describe "Ecto imports" do
    context "imports functions from Ecto" do
      before do
        allow(Ecto).to accept(:primary_key, fn(a) -> a end)
      end

      it "call Ecto function" do
        expect(primary_key(:test)).to eq(:test)
      end
    end

    context "imports functions from Ecto.Changeset" do
      before do
        allow(Ecto.Changeset).to accept(:merge, fn(a, b) -> a + b end)
      end

      it "call Ecto.Changeset function" do
        expect(merge(2, 2)).to eq(4)
      end

      context "it does not import change/1 and change/2" do
        before do
          allow(Ecto.Changeset).to accept(:change, fn(_a) -> :ok end)
          allow(Ecto.Changeset).to accept(:change, fn(_a, _b) -> :ok end)
        end

        it "call ESpec function" do
          expect(change(fn -> :ok end)).not_to eq(:ok)
          expect(change(fn -> :ok end, 2)).not_to eq(:ok)
        end
      end
    end

    context "imports functions from Ecto.Query" do
      before do
        allow(Ecto.Query).to accept(:exclude, fn(a, b) -> a + b end)
      end

      it "call Ecto.Query function" do
        expect(exclude(2, 2)).to eq(4)
      end
    end
  end

  describe "imports from ESpec.Phoenix.Extend" do
    it "calls function from ModelHelpers" do
      expect(module_helper_fun).to eq(:fun)
    end
  end
end
