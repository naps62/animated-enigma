defmodule AnimatedEnigma.GameController do
  use AnimatedEnigma.Web, :controller

  def index(conn, params) do
    conn
    |> render("index.html")
  end
end
