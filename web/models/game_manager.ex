defmodule AnimatedEnigma.GameManager do
  use GenServer

  alias AnimatedEnigma.{QuestionProvider, Game, Player}

  @max_players 2

  def start_link(initial_state) do
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  # client

  def user_joined(game_id, player_id) do
    GenServer.call(__MODULE__, {:user_joined, game_id, player_id})
  end

  def start(game_id) do
    GenServer.call(__MODULE__, {:start, game_id})
  end

  def add_fake_answer(game_id, player_id, answer) do
    GenServer.call(__MODULE__, {:add_fake_answer, game_id, player_id, answer})
  end

  def answer_question(game_id, player_id, answer) do
    GenServer.call(__MODULE__, {:answer_question, game_id, player_id, answer})
  end

  # server

  # user join
  def handle_call({:user_joined, game_id, player_id}, _from, state) do
    game = Map.get(state, game_id, Game.new(game_id))
    new_player = Player.new(player_id)
    updated_game = Game.add_player(game, new_player)

    new_state = Map.put(state, game_id, updated_game)

    {:reply, {:ok, updated_game}, new_state}
  end

  def handle_call({:start, game_id}, _from, state) do
    QuestionProvider.start_game(game_id)

    {:ok, question} = QuestionProvider.request_question(game_id)

    updated_game = Game.start_question(state[game_id], question)
    updated_state = Map.put(state, game_id, updated_game)

    {:reply, {:ok, updated_game}, updated_state}
  end


  def handle_call({:add_fake_answer, game_id, player_id, answer}, _from, state) do
    updated_game = Game.add_fake_answer(state[game_id], player_id, answer)
    updated_state = Map.put(state, game_id, updated_game)

    {:reply, {:ok, updated_game}, updated_state}
  end

  def handle_call({:answer_question, game_id, player_id, answer}, _from, state) do
    updated_game = Game.answer_question(state[game_id], player_id, answer)
    updated_state = Map.put(state, game_id, updated_game)

    {:reply, {:ok, updated_game}, updated_state}
  end
end
