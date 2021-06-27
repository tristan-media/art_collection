defmodule ArtCollectionWeb.PageController do
  use ArtCollectionWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
