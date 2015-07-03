defmodule App.UserRequestsSpec do

  use ESpec.Phoenix, request: App.Endpoint
  
  alias App.User
  
  let :valid_attrs, do: %{"name" => "Bill", "age" => 29}
  let :invalid_attrs, do: %{"name" => "a"}

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

    it "check custom_plug assigns" do
      subject |> should have_in_assigns(hello: "world")
    end
  end

  describe "create user" do
    context "check new.thml content" do
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

    context "post request" do
      context "success case" do
        subject! do: post(conn(), user_path(conn(), :create), %{"user" => valid_attrs})

        context "check response" do
          it do: should redirect_to(user_path(conn, :index))
          it do: should have_in_flash(info: "User created successfully.")
        end

        context "check record" do
          let :user, do: Repo.one(from u in User, select: u)
          
          it "check user attributes" do
            expect(user.name).to eq(valid_attrs["name"])
            expect(user.age).to eq(valid_attrs["age"])
          end
        end
      end

      context "error case" do
        subject! do: post(conn(), user_path(conn(), :create), %{"user" => invalid_attrs})

        context "check response" do
          it do: should render_template("new.html")
          it "check content" do
            should have_text_in("div .alert-danger li", "Name should be at least 3 characters")
          end
        end

        context "check record" do
          subject do: Repo.one(from u in User, select: u)
          it do: should be_nil
        end

      end
    end
  end

  describe "show user" do
    before do
      user = %User{name: "Bill", age: 25} |> Repo.insert
      {:ok, user: user}
    end

    subject! do: get(conn(), user_path(conn(), :show, __.user))
    it do: should be_successfull

    it "checks content" do
      should have_content_in("ul li", __.user.name)
      should have_content_in("ul li", __.user.age)
    end
  end

  describe "update user" do
    before do
      user = %User{name: "Jonh", age: 26} |> Repo.insert
      {:ok, user: user}
    end

    context "check new.thml content" do
      subject! do: get(conn(), user_path(conn(), :edit, __.user))

      it "checks method input" do
        should have_attributes_in("input", name: "_method", value: "put")
      end

      it "checks form" do
        should have_attributes_in("form", action: "/users/#{__.user.id}", method: "post")
      end
    end 

    context "put request" do
      context "success case" do
        subject! do: put(conn(), user_path(conn(), :update, __.user), %{"user" => valid_attrs})

        context "check response" do
          it do: should redirect_to(user_path(conn, :index))
          it do: should have_in_flash(info: "User updated successfully.")
        end

        context "check record" do
          let :user, do: Repo.one(from u in User, select: u)
          
          it "check user attributes" do
            expect(user.name).to eq(valid_attrs["name"])
            expect(user.age).to eq(valid_attrs["age"])
          end
        end
      end

      context "error case" do
        subject! do: put(conn(), user_path(conn(), :update, __.user), %{"user" => invalid_attrs})

        context "check response" do
          it do: should render_template("edit.html")
          it "check content" do
            should have_text_in("div .alert-danger li", "Name should be at least 3 characters")
          end
        end

        context "check record" do
          let :user, do: Repo.one(from u in User, select: u)
          it do: expect(user.name).to eq(__.user.name)
        end
      end
    end
  end

  describe "delete user" do
    before do
      user = %User{name: "Jonh", age: 26} |> Repo.insert
      {:ok, user: user}
    end

    subject! delete(conn(), user_path(conn(), :delete, __.user))

    context "check response" do
      it do: should redirect_to(user_path(conn, :index))
      it do: should have_in_flash(info: "User deleted successfully.")
    end

    context "check record" do
      subject do: Repo.one(from u in User, select: u)
      it do: should be_nil
    end
  end  

end