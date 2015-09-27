defmodule TestApp.PostTest do
  use TestApp.ModelCase

  alias TestApp.Post

  @valid_attrs %{title: "Post title", body: "some body content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Post.changeset(%Post{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Post.changeset(%Post{}, @invalid_attrs)
    refute changeset.valid?
  end
end
