defmodule AnimatedEnigma.GameChannel do
  use Phoenix.Channel

  alias AnimatedEnigma.{GameManager, Intro}

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
        send self(), {:game_start, Intro.random}
        send self(), {:update_game_state, game}

      _ -> nil
    end
  end

  def handle_in("next_question", %{"game_id" => game_id}, socket) do
    GameManager.next_question(game_id)
    |> handle_game_update(socket)
  end

  def handle_in("fake_answer", %{"game_id" => game_id, "player_id" => player_id, "answer" => answer }, socket) do
    GameManager.add_fake_answer(game_id, player_id, answer)
    |> handle_game_update(socket)
  end

  def handle_in("answer_question", %{"game_id" => game_id, "player_id" => player_id, "answer" => answer }, socket) do
    GameManager.answer_question(game_id, player_id, answer)
    |> handle_game_update(socket)
  end

  def handle_in("go_to_question_result", %{"game_id" => game_id}, socket) do
    GameManager.go_to_question_result(game_id)
    |> handle_game_update(socket)
  end

  def handle_in("go_to_scoreboard", %{"game_id" => game_id}, socket) do
    GameManager.go_to_scoreboard(game_id)
    |> handle_game_update(socket)
  end

  defp handle_game_update({:ok, game}, socket) do
    send self(), {:update_game_state, game}
    {:noreply, socket}
  end

  defp handle_game_update(_, socket) do
    {:noreply, socket}
  end


  def handle_info({:update_game_state, game}, socket) do
    IO.inspect game
    broadcast! socket, "game_update", game
    {:noreply, socket}
  end

  def handle_info({:game_start, intro}, socket) do
    IO.inspect intro
    broadcast! socket, "game_start", %{ intro: intro }
    {:noreply, socket}
  end

  def handle_info({:player_joined, player_id}, socket) do
    broadcast! socket, "player_joined", %{ player_id: player_id }
    {:noreply, socket}
  end
end
