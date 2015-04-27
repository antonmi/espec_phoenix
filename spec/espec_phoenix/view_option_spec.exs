Code.require_file("spec/espec_phoenix/requires.ex")

defmodule ViewOptionSpec do
	use ESpec.Phoenix, view: App.PostsView

	context "use ESpec.Phoenix.Views.Helpers" do
		it "has render" do
			expect(fn ->
		 		render("index.html", what: "world")
			end).to raise_exception(Phoenix.Template.UndefinedError)
		end
	end

end