defmodule TestApp.PostControllerSpec do
  use ESpec.Phoenix, controller: TestApp.PostController

  describe "index" do
    let :posts do
      [
        %TestApp.Post{id: 1, title: "Post title", body: "some body content"},
        %TestApp.Post{id: 2, title: "Post title", body: "some body content"},
      ]
    end

    before do: allow TestApp.Repo |> to(accept :all, fn(_) -> posts end)
    subject do: action :index

    it do: should be_successful
    it do: should have_http_status(:ok)
    it do: should have_in_assigns(posts: posts)
  end

  describe "show" do
    let :post, do: %TestApp.Post{id: 1, title: "Post title", body: "some body content"}
    before do: allow TestApp.Repo |> to(accept :get!, fn(TestApp.Post, 1) -> post end)

    subject do: action :show, %{"id" => 1}
    it do: is_expected |> to(be_successful)

    context "not found" do
      before do: allow TestApp.Repo |> to(accept :get!, fn(TestApp.Post, 1) -> nil end)
      it "raises exception" do
        expect fn -> action(:show, %{"id" => 1}) end  |> to(raise_exception)
      end
    end
  end
end
