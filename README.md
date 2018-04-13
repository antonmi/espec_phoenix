# ESpec.Phoenix
[![Build Status](https://travis-ci.org/antonmi/espec_phoenix.svg?branch=master)](https://travis-ci.org/antonmi/espec_phoenix)
[![Hex.pm](https://img.shields.io/hexpm/v/espec_phoenix.svg?style=flat-square)](https://hex.pm/packages/espec_phoenix)

##### ESpec helpers for Phoenix web framework.

Read about ESpec [here](https://github.com/antonmi/espec).

ESpec.Phoenix is a lightweight wrapper around ESpec which brings BDD to Phoenix web framework.

Use ESpec.Phoenix the same way as ExUnit in you Phoenix application.

There is [rumbrella](https://github.com/antonmi/espec_phoenix/tree/master/rumbrella) project from great [Programming Phoenix](https://pragprog.com/book/phoenix/programming-phoenix) book. One can find a lot of usefull examples there!

## Contents
- [Installation](#installation)
- [Migration from previous versions](#migration-from-previous-versions)
- [Model specs](#model-specs)
- [Controller specs](#controller-specs)
- [View specs](#view-specs)
- [Channel specs](#channel-specs)
- [Extensions](#extensions)
- [Contributing](#contributing)

## Installation

Add `espec_phoenix` to dependencies in the `mix.exs` file:

```elixir
def deps do
  ...
  {:espec_phoenix, "~> 0.6.9", only: :test},
  #{:espec_phoenix, github: "antonmi/espec_phoenix", only: :test}, to get the latest version
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
MIX_ENV=test mix espec_phoenix.init
```
The task creates `spec/spec_helper.exs`, `phoenix_helper.exs` and `espec_phoenix_extend.ex`.

Also you need to checkout your `Ecto` sandbox mode before each example and checkin it after. So `spec_helper.exs` should look like:
```elixir
#require phoenix_helper.exs
Code.require_file("#{__DIR__}/phoenix_helper.exs")

ESpec.configure fn(config) ->
  config.before fn(_tags) ->
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(YourApp.Repo)
  end

  config.finally fn(_shared) ->
    Ecto.Adapters.SQL.Sandbox.checkin(YourApp.Repo, [])
  end
end
```
The `espec_phoenix_extend.ex` file contains `ESpec.Phoenix.Extend` module.
Use this module to import or alias additional modules in your specs.

## Migration from previous versions
### There is no other matchers and helpers then ESpec and Phoenix have.
I've decided to remove all the custom assertions for 'changeset', 'conn' and 'content'.
The reason is to make specs more explicit like people used to see using ExUnit.

If you still want to use them, check out the [espec_phoenix_helpers](https://github.com/facto/espec_phoenix_helpers) project.



## Model specs
Use 'model' tag to identify model specs:
```elixir
use ESpec.Phoenix, model: YourModel
```
What ESpec.Phoenix does behind the scene is the following:
1. Uses `ModelHelpers`.
```elixir
defmodule ModelHelpers do
  defmacro __using__(_args) do
    quote do
      import Ecto
      import Ecto.Changeset, except: [change: 1, change: 2]
      import Ecto.Query
    end
  end
end
```
2. Calls `ESpec.Phoenix.Extend.model` function extending your spec module.

#### Note! We don't import `change/1` and `change/2` functions from `Ecto.Changeset` because they conflicts with ESpec functions. If you want to use them, call them directly with module prefix (`Ecto.Changeset.change`).

### Model spec example:
```elixir
defmodule Rumbl.UserSpec do
  use ESpec.Phoenix, model: User, async: true
  alias Rumbl.User

  @valid_attrs %{name: "A User", username: "eva", password: "secret"}
  @invalid_attrs %{}

  context "validation" do
    it "checks changeset with valid attributes" do
      changeset = User.changeset(%User{}, @valid_attrs)
      assert changeset.valid?
    end

    it "checks changeset with long username" do
      attrs = Map.put(@valid_attrs, :username, String.duplicate("a", 30))
      assert {:username, "should be at most 20 character(s)"} in
             errors_on(%User{}, attrs)
    end
  end
end
```
It is a good practice to place specs with side effects (db access) to another module:
```elixir
defmodule Rumbl.UserRepoSpec do
  use ESpec.Phoenix, model: User, async: true
  alias Rumbl.User

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
end
```
## Controller specs
Controller specs are integration tests that tests interactions among all parts of your application.
Use 'controller' tag to identify controller specs:
```elixir
use ESpec.Phoenix, controller: YourController
```
Your module will be extended with `ESpec.Phoenix.ModelHelpers` and also with `ESpec.Phoenix.ControllerHelpers`:
```elixir
defmodule ControllerHelpers do
  defmacro __using__(_args) do
    quote do
      import Plug.Conn
      import Phoenix.ConnTest, except: [conn: 0, build_conn: 0]

      def build_conn, do: Phoenix.ConnTest.build_conn()
    end
  end
end
```
#### Note! Deprecated Phoenix.ConnTest.conn/0 function is not imported.
Below is an example of controller specs:
```elixir
defmodule Rumbl.VideoControllerSpec do
  use ESpec.Phoenix, controller: VideoController, async: true

  describe "with logged user" do
    let :user, do: insert_user(username: "max")
    let! :user_video, do: insert_video(user, title: "funny cats")
    let! :other_video, do: insert_video(insert_user(username: "other"), title: "another video")

    let :response do
      assign(build_conn, :current_user, user)
      |> get(video_path(build_conn, :index))
    end

    it "lists all user's videos on index" do
      expect(html_response(response, 200)).to match(~r/Listing videos/)
    end

    it "has user_video title" do
      expect(response.resp_body).to have(user_video.title)
    end

    it "does not have other_video title" do
      expect(response.resp_body).not_to have(other_video.title)
    end
  end
end
```
Please note that due to the fact it's integraton tests, you can actually use it without specifying controller:
```elixir
defmodule Rumbl.VideoControllerRequestSpec do
  use ESpec.Phoenix, controller: true

  describe "with logged user" do
    let! :user_video, do: insert_video(user, title: "funny cats")

    let :response do
      build_conn |> get("/videos")
    end

    it "lists all user's videos on index" do
      expect(response.resp_body).to match(~r/Listing videos/)
    end
  end
end
```
## View specs
View specs also are extended with `ESpec.Phoenix.ControllerHelpers` and also imports `Phoenix.View`.
### Example
```elixir
defmodule Rumbl.VideoViewSpec do
  use ESpec.Phoenix, async: true, view: VideoView

  let :videos do
    [%Rumbl.Video{id: "1", title: "dogs"},
      %Rumbl.Video{id: "2", title: "cats"}]
  end

  describe "index.html" do
    let :content do
      render_to_string(Rumbl.VideoView, "index.html", conn: build_conn, videos: videos)
    end

    it do: expect(content).to have("Listing videos")

    it "has video titles" do
      for video <- videos do
        expect(content).to have(video.title)
      end
    end
  end
end
```
## Channel specs
```elixir
use ESpec.Phoenix, channel: YourChannel
```
Channel specs uses `Phoenix.ChannelTest` and `ESpec.Phoenix.ModelsHelpers`.
Use 'model' tag to identify model specs:
### Example
```elixir
defmodule Rumbl.Channels.VideoChannelSpec do
  use ESpec.Phoenix, channel: Rumbl.VideoChannel

  before do
    Ecto.Adapters.SQL.Sandbox.mode(Rumbl.Repo, {:shared, self()})
  end

  let! :user, do: insert_user(name: "Rebecca")
  let! :video, do: insert_video(user, title: "Testing")

  before do
    token = Phoenix.Token.sign(@endpoint, "user socket", user.id)
    {:ok, socket} = connect(Rumbl.UserSocket, %{"token" => token})

    {:shared, socket: socket}
  end

  before do
    for body <- ~w(one two) do
      video
      |> build_assoc(:annotations, %{body: body})
      |> Repo.insert!()
    end
  end

  before do
    {:ok, reply, socket} = subscribe_and_join(shared[:socket], "videos:#{video.id}", %{})
    {:shared, reply: reply, socket: socket}
  end

  it do: expect shared[:socket].assigns.video_id |> to(eq video.id)
  it do: assert %{annotations: [%{body: "one"}, %{body: "two"}]} = shared[:reply]
end
```
## Extensions
[espec_phoenix_helpers](https://github.com/facto/espec_phoenix_helpers) - assertions and helpers that used to be part of this project but were extracted out
[test_that_json_espec](https://github.com/facto/test_that_json_espec) - matchers for testing JSON

## Contributing
##### Contributions are welcome and appreciated!

Request a new feature by creating an issue.

Create a pull request with new features or fixes.

To run specs:
```sh
mix espec
```
There is a [rumbl application](https://github.com/antonmi/espec_phoenix/tree/master/rumbl) with specs inside.
Run `mix deps.get` in `rumbl` folder.
Change database settings in `test_app/config/test.exs`.
Run tests with `mix test` and `mix espec`.
