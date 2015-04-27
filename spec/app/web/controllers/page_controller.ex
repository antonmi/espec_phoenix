defmodule App.PageController do
  use App.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end
