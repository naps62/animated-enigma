defmodule AnimatedEnigma.GameController do
  use AnimatedEnigma.Web, :controller

  alias AnimatedEnigma.{Game, Player}

  def show(conn, %{"id" => id, "player_id" => player_id}) do
    game = %{public_id: id} |> Game.find_or_create()
    player = %{game_id: game.id, public_id: player_id} |> Player.find_or_create()

    IO.inspect player
    case player do
      {:error, _} -> render(conn, "error.html")

      _ -> 
        conn
        |> assign(:game, game)
        |> assign(:player, player)
        |> render("show.html")
    end

  end
end
