# ESpecPhoenix

##### ESpec helpers and matchers for Phoenix web framework.
Read about ESpec [here](https://github.com/antonmi/espec)

Tke a lok to examples in [app/spec](https://github.com/antonmi/espec_phoenix/tree/master/app/spec)

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
  preferred_cli_env: [espec: :test]
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

`phoenix_helper.exs` has Phoenix related configurations. You must require this helper in your `spec_helper.exs`
Also you need restart `Ecto` transaction before each example. So `spec_helper.exs` should look like:
```elixir
#require phoenix_helper.exs
Code.require_file("spec/phoenix_helper.exs")

ESpec.start
  
ESpec.configure fn(config) ->
  config.before fn ->
    #restart transactions
    Ecto.Adapters.SQL.restart_test_transaction(App.Repo, [])
  end
  
  config.finally fn(__) -> 
    
  end
end
```
The `espec_phoenix_extend.ex` file contains `ESpec.Phoenix.Extend` module.
Use this module to import or alias additional modules to your specs.






