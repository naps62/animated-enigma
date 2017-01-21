defmodule AnimatedEnigma.GameChannel do
  use Phoenix.Channel

  alias AnimatedEnigma.Game
  import Ecto.Query

  def join("game:" <> game_id, %{"player_id" => player_id} = _payload, socket) do
    case Game.user_joined(game_id, player_id) do
      {:ok, game} ->
        send self, {:after_join, game}
        {:ok, socket}

      {:error, reason} ->
        {:error, %{reason: reason}}
    end
  end

  def handle_in("start", %{"game_id" => game_id}, socket) do
    case Game.start(game_id) do
      {:ok, game} ->
        send self, {:after_start, game}
        {:noreply, socket}

      _ ->
        {:noreply, socket}
    end
  end

  def handle_info({:after_join, game}, socket) do
    update_game_state(socket, game)
    {:noreply, socket}
  end

  def handle_info({:after_start, game}, socket) do
    update_game_state(socket, game)
    {:noreply, socket}
  end

  defp update_game_state(socket, game) do
    broadcast! socket, "game_update", game
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
