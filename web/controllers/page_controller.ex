defmodule AnimatedEnigma.PageController do
  use AnimatedEnigma.Web, :controller

  def index(conn, _params) do
    conn
    |> assign(:counter, 0)
    |> render("index.html")
  end
end
