defmodule Rumbl.Channels.VideoChannelSpec do
  use ESpec.Phoenix, channel: Rumbl.VideoChannel

  before do
    Ecto.Adapters.SQL.Sandbox.mode(Rumbl.Repo, {:shared, self()})
  end

  let! :user, do: insert_user(name: "Rebecca")
  let! :video, do: insert_video(user(), title: "Testing")

  before do
    token = Phoenix.Token.sign(@endpoint, "user socket", user().id)
    {:ok, socket} = connect(Rumbl.UserSocket, %{"token" => token})

    {:shared, socket: socket}
  end

  describe "replies with video annotations" do
    before do
      for body <- ~w(one two) do
        video()
        |> build_assoc(:annotations, %{body: body})
        |> Repo.insert!()
      end
    end

    before do
      {:ok, reply, socket} = subscribe_and_join(shared[:socket], "videos:#{video().id}", %{})
      {:shared, reply: reply, socket: socket}
    end

    it do: expect shared[:socket].assigns.video_id |> to(eq video().id)
    it do: assert %{annotations: [%{body: "one"}, %{body: "two"}]} = shared[:reply]
  end

  context "when inserting new annotations" do
    before do
      {:ok, _, socket} = subscribe_and_join(shared[:socket], "videos:#{video().id}", %{})
      ref = push socket, "new_annotation", %{body: "the body", at: 0}
      {:shared, ref: ref}
    end

    it "checks reply and broadcast" do
       assert_reply shared[:ref], :ok, %{}
       assert_broadcast "new_annotation", %{}
    end
  end

  describe "InfoSys trigger" do
    before do
      insert_user(username: "wolfram")
      {:ok, _, socket} = subscribe_and_join(shared[:socket], "videos:#{video().id}", %{})
      ref = push socket, "new_annotation", %{body: "1 + 1", at: 123}
      {:shared, ref: ref}
    end


    it "checks reply and broadcast" do
      assert_reply shared[:ref], :ok, %{}
      assert_broadcast "new_annotation", %{body: "1 + 1", at: 123}
      assert_broadcast "new_annotation", %{body: "2", at: 123}
    end
  end
end
