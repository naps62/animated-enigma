require IEx
defmodule AnimatedEnigma.QuestionProvider do
  use GenServer

  @questions [
    "Qual é o sentido da vida?",
    "Quais?"
  ]

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def start_game(game_id) do
    GenServer.call(__MODULE__, {:start_game, game_id})
  end

  def request_question(game_id) do
    GenServer.call(__MODULE__, {:request_question, game_id})
  end

  def handle_call({:start_game, game_id}, _from, state) do
    new_state = Map.put(state, game_id, Enum.shuffle(@questions))

    {:reply, :ok, new_state}
  end

  def handle_call({:request_question, game_id}, _from, state) do
    case state[game_id] do
      [] ->
        {:reply, {:nope, "it's over bitch"}, state}

      [next_question | rest] ->
        new_state = %{state | game_id => rest}

        {:reply, {:ok, next_question}, new_state}
    end
  end
end
