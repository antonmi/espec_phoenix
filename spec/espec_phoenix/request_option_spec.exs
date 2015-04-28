Code.require_file("spec/espec_phoenix/requires.ex")
Code.require_file("app/lib/app/endpoint.ex")
Code.require_file("app/web/views/error_view.ex")
Code.require_file("app/config/config.exs")

defmodule RequestOptionSpec do
	use ESpec.Phoenix, request: App.Endpoint

	xcontext "use Phoenix.ConnTest and import ESpec.Phoenix.Assertions.Helpers" do
		subject! get(conn, "/hello", %{"hello" => "world"})
		it do: should be_successfull
	end

end