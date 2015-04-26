Code.require_file("spec/support/models/post.ex")

defmodule ESpecPhoenixSpec do

	use ESpec, async: true

	describe "model" do

		defmodule ModuleSpec do
			use ESpec.Phoenix, model: Phoenix.Models.Post
		
			it "imports Ecto.Model functions" do
				model = %Phoenix.Models.Post{id: 100500, title: "title"}
				expect(primary_key(model)).to eq([id: 100500])
			end

			it "imports Ecto.Query.from/2" do
				expect(fn -> 
					from(m in Phoenix.Models.Post, select: m)
				end).to_not raise_exception
			end

		end


	end


end