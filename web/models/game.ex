defmodule AnimatedEnigma.Game do
  use GenServer

  alias AnimatedEnigma.QuestionProvider

  @max_players 4

  def start_link(initial_state) do
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  # client

  def user_joined(game_id, player) do
    GenServer.call(__MODULE__, {:user_joined, game_id, player})
  end

  def start(game_id) do
    GenServer.call(__MODULE__, {:start, game_id})
  end

  # server

  # user join, but already 4 users are in
  def handle_call({:user_joined, %{players: players}, _player}, _from, state)
  when length(players) == @max_players do
    {:reply, {:error, "game is full"}, state}
  end

  # user join
  def handle_call({:user_joined, game_id, player}, _from, state) do
    new_state = case Map.get(state, game_id) do
      nil ->
        new_game = init_game(game_id, player)
        Map.put(state, game_id, new_game)

      game ->
        updated_game = %{
          game | players: Enum.uniq(game.players ++ [player])
        }

        Map.put(state, game_id, updated_game)
    end

    {:reply, {:ok, new_state[game_id]}, new_state}
  end

  def handle_call({:user_left, game_id, user_id}, _from, state) do
    new_users = state
                |> Map.get(game_id)
                |> Enum.reject(&(&1.id == user_id))

    new_state = Map.update!(state, game_id, fn(_) -> new_users end)

    {:reply, new_state, new_state}
  end


  def handle_call({:start, game_id}, _from, state) do
    QuestionProvider.start_game(game_id)

    {:ok, question} = QuestionProvider.request_question(game_id)

    updated_game = %{
      state[game_id] |
      state: :gather_answers,
      current_question: question,
    }
    updated_state = Map.put(state, game_id, updated_game)

    {:reply, {:ok, updated_game}, updated_state}
  end


  defp init_game(game_id, first_player) do
    %{
      game_id: game_id,
      state: :lobby,
      players: [first_player],
      chairman: first_player,
      current_question: nil
    }
  end
end
