defmodule AnimatedEnigma.GameChannel do
  use Phoenix.Channel

  alias AnimatedEnigma.GameManager

  def join("game:" <> game_id, %{"player_id" => player_id} = _payload, socket) do
    case GameManager.user_joined(game_id, player_id) do
      {:ok, game} ->
        send self(), {:update_game_state, game}
        send self(), {:player_joined, player_id}
        {:ok, socket}

      {:error, reason} ->
        {:error, %{reason: reason}}
    end
  end

  def handle_in("start", %{"game_id" => game_id}, socket) do
    case GameManager.start(game_id) do
      {:ok, game} ->
        send self(), {:update_game_state, game}

      _ -> nil
    end

    {:noreply, socket}
  end

  def handle_in("fake_answer", %{"game_id" => game_id, "player_id" => player_id, "answer" => answer }, socket) do
    case GameManager.add_fake_answer(game_id, player_id, answer) do
      {:ok, game} ->
        IO.inspect game
        send self(), {:update_game_state, game}

      _ -> nil
    end

    {:noreply, socket}
  end

  def handle_in("answer_question", %{"game_id" => game_id, "player_id" => player_id, "answer" => answer }, socket) do
    case GameManager.answer_question(game_id, player_id, answer) do
      {:ok, game} ->
        send self(), {:update_game_state, game}

      _ -> nil
    end

    {:noreply, socket}
  end

  def handle_info({:update_game_state, game}, socket) do
    IO.inspect game
    broadcast! socket, "game_update", game
    {:noreply, socket}
  end

  def handle_info({:player_joined, player_id}, socket) do
    broadcast! socket, "player_joined", %{ player_id: player_id }
    {:noreply, socket}
  end
end
