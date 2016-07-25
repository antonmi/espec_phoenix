defmodule Rumbl.VideoControllerTest do
  use ESpec.Phoenix, async: true, controller: VideoController

  describe "without user" do
    let :conn, do: init_conn

    it "requires user authentication on all actions" do
      Enum.each([
        get(conn, video_path(conn, :new)),
        get(conn, video_path(conn, :index)),
        get(conn, video_path(conn, :show, "123")),
        get(conn, video_path(conn, :edit, "123")),
        put(conn, video_path(conn, :update, "123", %{})),
        post(conn, video_path(conn, :create, %{})),
        delete(conn, video_path(conn, :delete, "123")),
      ], fn conn ->
        assert html_response(conn, 302)
        assert conn.halted
      end)
    end
  end

  describe "with logged user" do
    let :user, do: insert_user(username: "max")
    let! :user_video, do: insert_video(user, title: "funny cats")
    let! :other_video, do: insert_video(insert_user(username: "other"), title: "another video")

    let :response do
      assign(init_conn, :current_user, user)
      |> get(video_path(init_conn, :index))
    end

    it "lists all user's videos on index" do
      expect(html_response(response, 200)).to match(~r/Listing videos/)
    end

    it "has user_video title" do
      expect(response.resp_body).to have(user_video.title)
    end

    it "does not have other_video title" do
      expect(response.resp_body).not_to have(other_video.title)
    end
  end

  describe "with login_as tag", login_as: "max" do
    let :conn, do: shared[:conn]
    let :current_user, do: conn.assigns.current_user

    it "assigns current_user in conn" do
      expect(current_user.username).to eq("max")
    end

    describe "POST /videos" do
      alias Rumbl.Video

      context "when attributes are valid" do
        let :attrs, do: %{url: "http://youtu.be", title: "vid", description: "a vid"}
        let! :response, do: post(conn, video_path(conn, :create), video: attrs)

        it "creates video" do
          expect(Repo.get_by!(Video, attrs).user_id).to eq(current_user.id)
        end

        it "redirects to index" do
          expect(redirected_to(response)).to eq(video_path(response, :index))
        end
      end

      context "when attributes are invalid" do
        let :attrs, do: %{title: "invalid"}
        let :video_count, do: fn -> select(Rumbl.Video, [v], count(v.id)) |> Rumbl.Repo.one end

        it "does not create video" do
          make_post = fn -> post(conn, video_path(conn, :create), video: attrs) end
          expect(make_post).not_to change(video_count)
        end

        it "shows errors" do
          conn = post(conn, video_path(conn, :create), video: attrs)
          expect(html_response(conn, 200)).to match("check the errors")
        end
      end
    end

    describe "not authorized actions" do
      let :attrs, do: %{url: "http://youtu.be", title: "vid", description: "a vid"}

      let! :video do
        owner = insert_user(username: "owner")
        insert_video(owner, attrs)
      end

      let :another_user, do: insert_user(username: "another")
      let! :conn, do: assign(init_conn, :current_user, another_user)

      it "checks :show action" do
        assert_error_sent :not_found,
          fn -> get(conn, video_path(conn, :show, video))
        end
      end

      it "checks :edit action" do
        assert_error_sent :not_found, fn ->
          get(conn, video_path(conn, :edit, video))
        end
      end

      it "checks :update action" do
        assert_error_sent :not_found,
          fn -> get(conn, video_path(conn, :update, video, attrs))
        end
      end

      it "checks :delete action" do
        assert_error_sent :not_found,
          fn -> delete(conn, video_path(conn, :delete, video))
        end
      end
    end
  end
end
