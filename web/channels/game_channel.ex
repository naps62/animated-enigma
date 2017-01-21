defmodule AnimatedEnigma.GameChannel do
  use Phoenix.Channel

  alias AnimatedEnigma.Game
  import Ecto.Query

  def join("game:" <> game_id, %{"player_id" => player_id} = _message, socket) do
    users = Game.user_joined(game_id, player_id)[game_id]

    # TODO babel-plugin-transform-class-properties
    send self, {:after_join, users}

    {:ok, socket}
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
