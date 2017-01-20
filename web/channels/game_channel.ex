defmodule AnimatedEnigma.GameChannel do
  use Phoenix.Channel

  def join("game:join", message, socket) do
    {:ok, %{value: 0}, socket}
  end

  # maybe
  # def handle_in("new_player", message, socket) do
  # end

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
