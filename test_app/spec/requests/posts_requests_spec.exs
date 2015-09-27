defmodule TestApp.PostsRequestsSpec do
  use ESpec.Phoenix, request: TestApp.Endpoint

  describe "index" do
    before do
      {:ok, ex1} = %TestApp.Post{title: "Post title 1", body: "some body content"} |> TestApp.Repo.insert
      {:ok, ex2} = %TestApp.Post{title: "Post title 2", body: "some body content"} |> TestApp.Repo.insert
      {:ok, ex1: ex1, ex2: ex2}
    end

    subject! do: get(conn(), post_path(conn(), :index))
    it do: should be_successful

    context "check body" do
      let :html, do: subject.resp_body

      it do: html |> should have_content shared.ex1.title
      it do: html |> should have_text shared.ex2.title
    end
  end

  context "create post" do
    context "check new page" do
      subject! do: get(conn(), post_path(conn(), :new))
      it "checks inputs" do
        should have_selector("input#post_title")
        should have_selector("input#post_body")
      end

      it "check text in labels" do
        should have_text_in("label", "Title")
        should have_content_in("label", "Body")
      end

      it "checks form" do
        should have_attributes_in("form", :action)
        should have_attributes_in("form", [:action, :method])
        should have_attributes_in("form", action: "/posts")
        should have_attributes_in("form", action: "/posts", method: "post")
      end
    end

    context "post request" do
      let :valid_attrs, do: %{title: "Post title", body: "some body content"}

      context "success case" do
        subject! do: post(conn(), post_path(conn(), :create), %{"post" => valid_attrs})

        context "check response" do
          it do: should redirect_to(post_path(conn, :index))
          it do: should have_in_flash(info: "Post created successfully.")
        end

        context "check record" do
          let :post, do: Repo.one(from p in TestApp.Post, select: p)
          it do: expect(post.title).to eq(valid_attrs[:title])
        end
      end

      context "error case" do
        let :invalid_attrs, do: %{title: "", body: "short body"}
        subject! do: post(conn(), post_path(conn(), :create), %{"post" => invalid_attrs})

        context "check response" do
          it do: should render_template("new.html")
          it "check content" do
            should have_text_in("div .alert-danger", "Oops, something went wrong! Please check the errors below:")
          end
        end

        context "check record" do
          it do: Repo.one(from p in TestApp.Post, select: p) |> should be_nil
        end
      end
    end
  end
end
