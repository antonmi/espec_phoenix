Code.require_file("spec/espec_phoenix/requires.ex")

defmodule ModelOptionSpec do
	use ESpec.Phoenix, model: App.Post

	it "imports Ecto.Model functions" do
		model = %App.Post{id: 100500, title: "title"}
		expect(primary_key(model)).to eq([id: 100500])
	end

	it "imports Ecto.Query.from/2" do
		expect(fn -> 
			from(m in App.Post, select: m)
		end).to_not raise_exception
	end
end
