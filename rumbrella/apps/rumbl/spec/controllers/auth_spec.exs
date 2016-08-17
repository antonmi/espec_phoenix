defmodule Rumbl.AuthSpec do
  use ESpec.Phoenix, async: true, controller: Rumbl.AuthSpec
  alias Rumbl.Auth

  before do
    conn =
      build_conn
      |> bypass_through(Rumbl.Router, :browser)
      |> get("/")
    {:ok, %{conn: conn}}
  end

  let :conn, do: shared[:conn]

  it "authenticate_user halts when no current_user exists" do
    conn = Auth.authenticate_user(conn, [])
    assert conn.halted
  end

  it "authenticate_user continues when the current_user exists" do
    conn =
      conn
      |> assign(:current_user, %Rumbl.User{})
      |> Auth.authenticate_user([])
    refute conn.halted
  end

  it "login puts the user in the session" do
    login_conn =
      conn
      |> Auth.login(%Rumbl.User{id: 123})
      |> send_resp(:ok, "")
    next_conn = get(login_conn, "/")
    assert get_session(next_conn, :user_id) == 123
  end

  it "logout drops the session" do
    logout_conn =
      conn
      |> put_session(:user_id, 123)
      |> Auth.logout()
      |> send_resp(:ok, "")
    next_conn = get(logout_conn, "/")
    refute get_session(next_conn, :user_id)
  end

  it "call places user from session into assigns" do
    user = insert_user()
    conn =
      conn
      |> put_session(:user_id, user.id) |> Auth.call(Repo)
      assert conn.assigns.current_user.id == user.id
  end

  it "call with no session sets current_user assign to nil" do
    conn = Auth.call(conn, Repo)
    assert conn.assigns.current_user == nil
  end

  it "login with a valid username and pass" do
    user = insert_user(username: "me", password: "secret")
    {:ok, conn} =
      Auth.login_by_username_and_pass(conn, "me", "secret", repo: Repo)

    assert conn.assigns.current_user.id == user.id
  end

  it "login with a not found user" do
    assert {:error, :not_found, _conn} =
    Auth.login_by_username_and_pass(conn, "me", "secret", repo: Repo)
  end

  it "login with password mismatch" do
    _ = insert_user(username: "me", password: "secret")
    assert {:error, :unauthorized, _conn} =
      Auth.login_by_username_and_pass(conn, "me", "wrong", repo: Repo)
  end

  it "login with a not found user" do
    assert {:error, :not_found, _conn} =
    Auth.login_by_username_and_pass(conn, "me", "secret", repo: Repo)
  end

  it "login with password mismatch" do
    _ = insert_user(username: "me", password: "secret")
    assert {:error, :unauthorized, _conn} =
      Auth.login_by_username_and_pass(conn, "me", "wrong", repo: Repo)
  end
end
