defmodule AnimatedEnigma.GameChannel do
  use Phoenix.Channel

  alias AnimatedEnigma.{Game, Player, Repo}
  import Ecto.Query

  def join("game:" <> game_id, %{"player_id" => player_id} = _message, socket) do
    state = state_for(game_id, player_id)

    {:ok, state, socket}
  end

  defp state_for(game_id, player_id) do
    game = Game |> where(public_id: ^game_id) |> Repo.one
    players = Player |> where(game_id: ^game.id) |> Repo.all
    me = Player |> where(game_id: ^game.id, public_id: ^player_id) |> Repo.one

    %{
      game: game,
      me: me,
      players: players
    }
  end

  # def handle_out("next_question", ...)
  # def handle_in("other_answer", ...)
  # def handle_out("question_ready", ...)
  # def handle_in("player_answer", ...)
  # def handle_out("question_result", ...)

  # def handle_in("inc", %{"value" => value}, socket) do
  #   broadcast! socket, "new_value", %{value: value + 1}
  #   {:noreply, socket}
  # end
end
