defmodule App.UserViewsSpec do

  use ESpec.Phoenix, view: App.UserView

  alias App.User

  let :user, do: %User{id: 1, age: 25, name: "Jim"}
  let :user2, do: %User{id: 2, age: 26, name: "Jonh"}
  
  let :users, do: [user, user2]

  describe "index.html" do
    subject do: render("index.html", users: users)
    
    it do: should have_text("Listing users")
    it do: should have_text_in("table td", user.name)
    it do: should have_text_in("table td", user2.name)
  end

  describe "show" do
    subject do: render("show.html", user: user)
    it do: should have_text("Show user")
    
    it do: should have_text_in("ul li", user.name)
    it do: should have_text_in("ul li", user.age)
    
    it do: should have_attribute_in("a", href: user_path(conn, :index))
  end

  describe "new.html" do
    let :changeset, do: User.changeset(%User{})
    subject do: render("new.html", changeset: changeset)

    it do: should have_text("New user")
    it do: should have_attributes_in("form", action: "/users", method: "post")
    it do: should have_selector("input #user_name")
    it do: should have_selector("input #user_age")
  end

  describe "edit.html" do
    let :changeset, do: User.changeset(user)
    subject do: render("new.html", changeset: changeset)
    
    it do: should have_attributes_in("form", action: "/users", method: "post")
    it do: should have_attributes_in("input #user_name", value: user.name)
    it do: should have_attributes_in("input #user_age", value: user.age)
  end
end
  