defmodule App.UserRequestsSpec do

  use ESpec.Phoenix, request: App.Endpoint
  
  alias App.User
  
  describe "list user" do
    before do
      user1 = %User{name: "Bill", age: 25} |> Repo.insert
      user2 = %User{name: "Jonh", age: 26} |> Repo.insert
      {:ok, user1: user1, user2: user2}
    end

    subject! do: get(conn(), user_path(conn(), :index))
    it do: should be_successfull

    it "checks content" do
      should have_content __.user1.name
      should have_content __.user2.name
    end
  end

  describe "create user" do
    context "check content" do
      subject! do: get(conn(), user_path(conn(), :new))

      it "checks inputs" do
        should have_selector("input #user_name")
        should have_selector("input #user_age")
      end

      it "check text in labels" do
        should have_text_in("label", "Name")
        should have_content_in("label", "Age")
      end

      it "checks form" do
        should have_attributes_in("form", :action)
        should have_attributes_in("form", [:action, :method])
        should have_attributes_in("form", action: "/users")
        should have_attributes_in("form", action: "/users", method: "post")
      end
    end 
  end

end