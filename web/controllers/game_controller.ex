defmodule AnimatedEnigma.GameController do
  use AnimatedEnigma.Web, :controller

  alias AnimatedEnigma.{Game, Player}

  def show(conn, %{"id" => id, "player_id" => player_id}) do
    case true do
      {:error, _} -> render(conn, "error.html")

      _ ->
        conn
        |> assign(:game_id, id)
        |> assign(:player_id, player_id)
        |> render("show.html")
    end

  end
end
