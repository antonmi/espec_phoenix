defmodule ControllerSetup do
  use ESpec.Phoenix, controller: :setup

  def setup(_controller, opts) do
    if username = opts[:login_as] do
      user = insert_user(username: username)
      conn = assign(build_conn(), :current_user, user)
      {:shared, conn: conn}
    else
      {:shared, []}
    end
  end

  def on_exit(_controller, _shared) do
    # IO.inspect(shared)
  end
end
