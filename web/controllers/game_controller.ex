defmodule AnimatedEnigma.GameController do
  use AnimatedEnigma.Web, :controller

  def show(conn, %{"game" => %{"public_id" => game_id, "username" => player_id}}) do
    case true do
      {:error, _} -> render(conn, "error.html")

      _ ->
        conn
        |> assign(:game_id, game_id)
        |> assign(:player_id, player_id)
        |> render("show.html")
    end

  end
end
