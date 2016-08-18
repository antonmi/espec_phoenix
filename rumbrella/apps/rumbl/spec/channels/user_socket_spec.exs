defmodule Rumbl.Channels.UserSocketSpec do
  use ESpec.Phoenix, async: true, channel: Rumbl.UserSocket
  alias Rumbl.UserSocket

  context "with valid token" do
    let :token, do: Phoenix.Token.sign(@endpoint, "user socket", "123")

    it "assigns user_id" do
      {:ok, socket} = connect(UserSocket, %{"token" => token})
      expect socket.assigns.user_id |> to(eq "123")
    end
  end

  context "with invalid token" do
    it do: expect connect(UserSocket, %{"token" => "1313"}) |> to(eq :error)
    it do: expect connect(UserSocket, %{}) |> to(eq :error)
  end
end
