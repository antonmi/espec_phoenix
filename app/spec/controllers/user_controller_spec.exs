defmodule App.UserControllerSpec do

   use ESpec.Phoenix, controller: App.UserController

    describe "index" do
      let :users do
        [ 
          %App.User{age: 25, name: "Jim"},
          %App.User{age: 26, name: "Jonh"}
        ]
      end

      before do
        allow(App.Repo).to accept(:all, fn -> users end)
      end

      it do
        IO.inspect App.Repo.all
      end

    end
end