defmodule Rumbl.UserRepoTest do
  use ESpec.Phoenix, async: true, model: User
  alias Rumbl.User
  alias Rumbl.Category

  @valid_attrs %{name: "A User", username: "eva"}

  describe "converting unique_constraint on username to error" do
    before do: insert_user(username: "eric")
    let :changeset do
      attrs = Map.put(@valid_attrs, :username, "eric")
      User.changeset(%User{}, attrs)
    end

    it do: expect(Repo.insert(changeset)).to be_error_result

    context "when name has been already taken" do
      let :new_changeset do
        {:error, changeset} = Repo.insert(changeset)
        changeset
      end

      it "has error" do
        error = {:username, {"has already been taken", []}}
        expect(new_changeset.errors).to have(error)
      end
    end
  end

  describe "alphabetical order by name" do
    before do
      Repo.insert!(%Category{name: "c"})
      Repo.insert!(%Category{name: "a"})
      Repo.insert!(%Category{name: "b"})
    end

    let :query do
      query = Category |> Category.alphabetical()
      from c in query, select: c.name
    end

    it do: expect(Repo.all(query)).to eq(~w(a b c))
  end
end
