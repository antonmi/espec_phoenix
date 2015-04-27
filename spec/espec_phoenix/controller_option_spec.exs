Code.require_file("spec/espec_phoenix/requires.ex")

defmodule ContrellerOptionSpec do
	use ESpec.Phoenix, controller: App.PostsController

	context "use Plug.Test" do
		it "conn is Phoenix.ConnTest.conn()" do
			{module, _opts} = conn.adapter
			expect(module).to eq(Plug.Adapters.Test.Conn)
		end

		context "check Plug.Test.put_req_cookie" do
			let :con, do: put_req_cookie(conn(), "a", "b")
			it "check cookie" do
				cookies = fetch_cookies(con).cookies
				cookies |> should eq %{"a" => "b"}
			end
		end
	end

	context "import Phoenix.Controller" do
		it "has :controller_module function" do
			controller_module(conn) |> should eq App.PostsController
		end
	end

	context "use ESpec.Phoenix.Controllers.Helpers" do
	 	let :response, do: get(conn, :hello, %{"hello" => "world"})
		it do: response.resp_body |> should eq("world")
	end

	context "import ESpec.Phoenix.Assertions.Helpers" do
		subject get(conn, :hello, %{"hello" => "world"})
		it do: should be_successfull
	end

end