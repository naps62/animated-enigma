defmodule AnimatedEnigma.Game do
  use GenServer

  def start_link(initial_state) do
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  # client

  def user_joined(game, player) do
    GenServer.call(__MODULE__, {:user_joined, game, player})
  end

  # server

  def handle_call({:user_joined, game, player}, _from, state) do
    IO.inspect state
    new_state = case Map.get(state, game) do
      nil -> Map.put(state, game, %{players: [player]})
      game_state ->
        updated_game = Map.put(game_state, :players, Enum.uniq([player | game_state.players]))
        Map.put(state, game, updated_game)
    end

    IO.inspect new_state
    {:reply, new_state, new_state}
  end

  def handle_call({:users_in_game, game}, _from, state) do
    {:reply, Map.get(state, game), state}
  end

  def handle_call({:user_left, game, user_id}, _from, state) do
    new_users = state
                |> Map.get(game)
                |> Enum.reject(&(&1.id == user_id))

    new_state = Map.update!(state, game, fn(_) -> new_users end)

    {:reply, new_state, new_state}
  end
end
