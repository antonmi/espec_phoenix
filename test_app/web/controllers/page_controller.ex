defmodule TestApp.PageController do
  use TestApp.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
