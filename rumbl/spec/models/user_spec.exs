defmodule Rumbl.UserTest do
  use ESpec.Phoenix, async: true, model: User
  alias Rumbl.User

  @valid_attrs %{name: "A User", username: "eva", password: "secret"}
  @invalid_attrs %{}

  context "validation" do
    it "changeset with valid attributes" do
      changeset = User.changeset(%User{}, @valid_attrs)
      assert changeset.valid?
    end

    it "changeset with invalid attributes" do
      changeset = User.changeset(%User{}, @invalid_attrs)
      refute changeset.valid?
    end

    it "changeset does not accept long usernames" do
      attrs = Map.put(@valid_attrs, :username, String.duplicate("a", 30))
      assert {:username, "should be at most 20 character(s)"} in
             errors_on(%User{}, attrs)
    end
  end


  context "password" do
    context "password length" do
      let :changeset do
        attrs = Map.put(@valid_attrs, :password, "12345")
        User.registration_changeset(%User{}, attrs)
      end

      it "has error" do
        error = {:password, {"should be at least %{count} character(s)", count: 6}}
        expect(changeset.errors).to have(error)
      end
    end

    context "password hash" do
      let :changeset do
        attrs = Map.put(@valid_attrs, :password, "123456")
        User.registration_changeset(%User{}, attrs)
      end

      before do
        {:shared, changeset.changes}
      end

      it do: assert changeset.valid?
      it do: assert shared[:password]
      it do: assert Comeonin.Bcrypt.checkpw(shared[:password], shared[:password_hash])
    end
  end
end
