defmodule ESpec.Phoenix.Controllers.Helpers do
	defmacro __using__(args) do
		quote do
			use Plug.Test

			def action(action, params \\ %{}, connection \\ build_conn()) do
				conn = connection
				|> put_private(:phoenix_controller, @controller)
				|> Phoenix.Controller.put_view(Phoenix.Controller.__view__(@controller))
				|> with_session
				|> Phoenix.ConnTest.fetch_flash()

				apply(@controller, action, [conn, params])
			end

			@session Plug.Session.init(
				store: :cookie,
				key: "_app",
				encryption_salt: "yadayada",
				signing_salt: "yadayada"
			)

			defp with_session(conn) do
				conn
				|> Map.put(:secret_key_base, String.duplicate("abcdefgh", 8))
				|> Plug.Session.call(@session)
				|> Plug.Conn.fetch_session()
			end
		end
	 end
end
