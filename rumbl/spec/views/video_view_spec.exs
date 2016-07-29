defmodule Rumbl.VideoViewSpec do
  use ESpec.Phoenix, async: true, view: VideoView

  let :videos do
    [%Rumbl.Video{id: "1", title: "dogs"},
      %Rumbl.Video{id: "2", title: "cats"}]
  end


  describe "index.html" do
    let :content do
      render_to_string(Rumbl.VideoView, "index.html", conn: build_conn, videos: videos)
    end

    it do: expect(content).to have("Listing videos")

    it "has video titles" do
      for video <- videos do
        expect(content).to have(video.title)
      end
    end
  end

  describe "new.html" do

    let :content do
      changeset = Rumbl.Video.changeset(%Rumbl.Video{})
      categories = [{"cats", 123}]

      render_to_string(Rumbl.VideoView, "new.html", conn: build_conn,
        changeset: changeset, categories: categories)
    end

    it do: expect(content).to have("New video")
  end
end
