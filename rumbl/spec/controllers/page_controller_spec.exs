defmodule Rumbl.PageControllerTest do
  use ESpec.Phoenix, async: true, controller: PageController

  it "GET /" do
    conn = get build_conn, "/"
    assert html_response(conn, 200) =~ "Hello Rumbl!"
    expect(html_response(conn, 200)) |> to(match "Hello Rumbl!")
  end
end
