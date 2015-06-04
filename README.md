# ESpecPhoenix

##### ESpec helpers and matchers for Phoenix web framework.
Read about ESpec [here](https://github.com/antonmi/espec).

There are examples in [app/spec](https://github.com/antonmi/espec_phoenix/tree/master/app/spec).

## Contents
- [Installation](#installation)

## Installation

Add `espec_phoenix` to dependencies in the `mix.exs` file:

```elixir
def deps do
  ...
  {:espec_phoenix, "~> 0.1.2", only: :test, app: false},
  #{:espec, github: "antonmi/espec_phoenix", only: :test, app: false}, to get the latest version
  ...
end
```
```sh
mix deps.get
```
Set `preferred_cli_env` for `espec` in the `mix.exs` file:

```elixir
def project do
  ...
  preferred_cli_env: [espec: :test],
  ...
end
```
Run:
```sh
MIX_ENV=test mix espec.init
```
The task creates `spec/spec_helper.exs` and `spec/example_spec.exs`.
Run:
```sh
MIX_ENV=test mix espec_phoenix.init
```
The task creates `phoenix_helper.exs`, `espec_phoenix_extend.ex`, and basic specs folders and places simple examples there.

`phoenix_helper.exs` has Phoenix related configurations.
Replace `App.Repo` with your repo module.

You must require this helper in your `spec_helper.exs`.
Also you need restart `Ecto` transaction before each example. So `spec_helper.exs` should look like:
```elixir
#require phoenix_helper.exs
Code.require_file("spec/phoenix_helper.exs")

ESpec.start
  
ESpec.configure fn(config) ->
  config.before fn ->
    #restart transactions
    Ecto.Adapters.SQL.restart_test_transaction(YourApplication.Repo, [])
  end
  
  config.finally fn(__) -> 
    
  end
end
```
The `espec_phoenix_extend.ex` file contains `ESpec.Phoenix.Extend` module.
Use this module to import or alias additional modules to your specs.

## Model specs
### Example
```elixir
defmodule App.UserSpec do
  use ESpec.Phoenix, model: App.User
  alias App.User

  let :valid_attrs, do: %{age: 42, name: "some content"}
  let :invalid_attrs, do: %{}

  context "valid changeset" do
    subject do: User.changeset(%User{}, valid_attrs)
    it do: should be_valid
  end
end  
```
#### Changeset helpers
```elixir
expect(changeset).to be_valid
... have_errors(:name)
... have_errors([:name, :surname])
... have_errors(name: "can't be blank", surname: "can't be blank")

```

## Controller specs
There is the `action/2` helper function wich call controller functions directy.
### Example
```elixir
defmodule App.UserControllerSpec do
  use ESpec.Phoenix, controller: App.UserController
  alias App.User
  
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
end
```

#### Conn helpers
##### Check status
```elixir
expect(res_conn).to be_successfull  #or be_success
... be_redirection                  #be_redirect
... be_not_found                    #be_missing
... be_server_error                 #be_error

... have_http_status(code)
... redirect_to(user_path(conn, :index))
```
##### Check template and view
```elixir
expect(res_conn).to render_template("index.html")
... use_view(App.UserView)
```
##### Check assigns
```elixir
expect(res_conn).to have_in_assigns(:users)
... have_in_assigns([:users, :options])
... have_in_assigns(users: users, options: options)
```
##### Check flash
```elixir
expect(res_conn).to have_in_flash(:info)
... have_in_flash(info: "User created successfully.")
```
## View specs
There is the `render/2` helper function available in the view specs.
### Example
```elixir
defmodule App.UserViewsSpec do
  use ESpec.Phoenix, view: App.UserView
  alias App.User
  
  describe "show" do
    let :user, do: %User{id: 1, age: 25, name: "Jim"}
    subject do: render("show.html", user: user)
   
    it do: should have_text("Show user")
    it do: should have_text_in("ul li", user.name)
    it do: should have_text_in("ul li", user.age)
    it do: should have_attribute_in("a", href: user_path(conn, :index))
  end
end
```
ESpec.Phoenix uses [Floki](https://github.com/philss/floki) to parse html.
There are some mathers for html string or for `conn` structure.
#### Content helpers
##### Check presence of plain text
```elixir
expect(html).to have_text("some text")    #String.contains?(html, "some text")
... have_content("some text")
```
##### Check presence of some selector
```elixir
expect(html).to have_selector("input #user_name")   #Floki.find(html, "input #user_name")
```

##### Check text in the selector
```elixir
expect(html).to have_text_in("label", "Name")
```
##### Check attributes in the selector
```elixir
expect(html).to have_attributes_in("form", action: "/users", method: "post")
```
## Requests specs
Requests specs tests request/response cycles from end to end using a black box approach.
Functions for corresponding http methods are imported from `Phoenix.ConnTest`.
Both 'Conn helpers' and 'Content helpers' available.
### Example
```elixir
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
end  
```


