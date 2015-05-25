defmodule App.UserSpec do

  use ESpec.Phoenix, model: App.User

  alias App.User

  let :valid_attrs, do: %{age: 42, name: "some content"}
  let :invalid_attrs, do: %{}

  context "valid changeset" do
    subject do: User.changeset(%User{}, valid_attrs)
    it do: should be_valid
  end

  context "invalid changeset" do
    subject do: User.changeset(%User{}, invalid_attrs)

    it do: should_not be_valid
    it do: should have_errors(:name)
    it do: should have_errors([:name, :age])
    it do: should have_errors([name: "can't be blank"])
    it do: should have_errors([name: "can't be blank", age: "can't be blank"])
  end

  



end