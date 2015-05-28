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
  {:espec_phoenix, "~> 0.1.0", only: :test, app: false},
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
### Example
```elixir
defmodule App.UserControllerSpec do
   use ESpec.Phoenix, controller: App.UserController

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




