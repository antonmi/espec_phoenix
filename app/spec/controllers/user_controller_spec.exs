defmodule App.UserControllerSpec do

  use ESpec.Phoenix, controller: App.UserController

  alias App.User

  let :valid_attrs, do: %{"name" => "Bill", "age" => 29}
  let :invalid_attrs, do: %{"name" => "a"}

  describe "index" do
    let :users do
      [ 
        %User{id: 1, age: 25, name: "Jim"},
        %User{id: 2, age: 26, name: "Jonh"}
      ]
    end

    before do
      allow(Repo).to accept(:all, fn
        User -> users 
        any -> passthrough([any])
      end)
    end

    subject do: action :index

    it do: should be_successfull
    it do: should have_http_status 200

    it do: should render_template("index.html")
    it do: should use_view(App.UserView)

    context "check assigns" do
      it do: should have_in_assigns(:users)
      it do: should have_in_assigns(users: users)
    end
  end

  describe "new" do
    subject do: action :new

    it do: should be_successfull
    it do: should have_in_assigns(changeset: User.changeset(%User{}))
  end

  describe "create" do
    context "success case" do
      subject do: action(:create, %{"user" => valid_attrs})

      it do: should be_redirection
      it do: should redirect_to(user_path(conn, :index))
      
      context "check flash" do
        it do: should have_in_flash(:info)
        it do: should have_in_flash(info: "User created successfully.")
      end
    end

    context "fail case" do
      subject do: action(:create, %{"user" => invalid_attrs})

      it do: should_not be_redirection
      it do: should render_template("new.html")
    end
  end

  describe "show" do
    let :user, do: %User{id: 1, age: 25, name: "Jim"} 

    before do
      allow(Repo).to accept(:get, fn
        User, 1 -> user
        User, id -> passthrough([id])
      end)
    end

    subject do: action(:show, %{"id" => 1})

    it do: should be_successfull
    it do: should render_template("show.html")

    it do: should have_in_assigns(user: user)
  end

  describe "edit" do
    let :user, do: %App.User{id: 1, age: 25, name: "Jim"} 

    before do
      allow(Repo).to accept(:get, fn
        User, 1 -> user
        User, id -> :meck.passthrough([id])
      end)
    end

    subject do: action(:edit, %{"id" => 1})

    it do: should be_successfull
    it do: should render_template("edit.html")

    let :changeset, do: User.changeset(user) 
    it do: should have_in_assigns(user: user, changeset: changeset)
  end

  describe "update" do
    let :user, do: %App.User{id: 1, age: 25, name: "Jim"}
    
    before do
      allow(Repo).to accept(:get, fn
        User, 1 -> user
        User, id -> :meck.passthrough([id])
      end)
      allow(App.Repo).to accept(:update)
    end

    context "success case" do
      subject do: action(:update, %{"id" => 1, "user" => valid_attrs})

      it do: should redirect_to(user_path(conn, :index))
      it do: should have_in_flash(info: "User updated successfully.")
    end

    context "fail case" do
      subject do: action(:update, %{"id" => 1, "user" => invalid_attrs})

      it do: should_not be_redirection
      it do: should render_template("edit.html")
    end
  end

  describe "delete" do
    before do
      allow(Repo).to accept(:delete)
    end

    subject do: action(:delete, %{"id" => 1})

    it do: should redirect_to(user_path(conn, :index))
    it do: should have_in_flash(info: "User deleted successfully.")
  end

end
