defmodule App.UserRequestsSpec do

  use ESpec.Phoenix, request: App.Endpoint
  
  alias App.User
  
  describe "list user" do
    before do
      user1 = %User{name: "Bill", age: 25} |> Repo.insert
      user2 = %User{name: "Jonh", age: 26} |> Repo.insert
      {:ok, user1: user1, user2: user2}
    end

    let! :response, do: get(conn(), user_path(conn(), :index))
    it do: expect(response).to be_successfull

    let :body, do: response.resp_body
    it "checks body" do
      expect(body).to have_content __.user1.name
      expect(body).to have_content __.user2.name
    end
  end

  describe "create user" do
    context "check form" do
      let! :response, do: get(conn(), user_path(conn(), :new))
      let :body, do: response.resp_body

      it do: IO.inspect response

      it "checks inputs" do
        expect(body).to have_selector("input #user_name")
        expect(body).to have_selector("input #user_age")
      end

      it "check text in labels" do
        expect(body).to have_text_in("label", "Name")
        expect(body).to have_content_in("label", "Age")
      end

      it "check form" do
        expect(body).to have_attributes_in("form", [:action, :method])
        expect(body).to have_attributes_in("form", action: "/users")
        expect(body).to have_attributes_in("form", action: "/users", method: "post")
      end

      it do
        html = App.UserRequestsSpec.body
        require IEx; IEx.pry
      end


    end 
  end

end