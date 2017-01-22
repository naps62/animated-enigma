defmodule AnimatedEnigma.GameManager do
  use GenServer

  alias AnimatedEnigma.{QuestionProvider, Game, Player}

  def start_link(initial_state) do
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  # client

  def user_joined(game_id, player_id) do
    GenServer.call(__MODULE__, {:user_joined, game_id, player_id})
  end

  def start(game_id) do
    GenServer.call(__MODULE__, {:start, game_id})
    GenServer.call(__MODULE__, {:next_question, game_id})
  end

  def next_question(game_id) do
    GenServer.call(__MODULE__, {:next_question, game_id})
  end

  def add_fake_answer(game_id, player_id, answer) do
    GenServer.call(__MODULE__, {:add_fake_answer, game_id, player_id, answer})
  end

  def answer_question(game_id, player_id, answer) do
    GenServer.call(__MODULE__, {:answer_question, game_id, player_id, answer})
  end

  def go_to_question_result(game_id) do
    GenServer.call(__MODULE__, {:go_to_question_result, game_id})
  end

  def go_to_scoreboard(game_id) do
    GenServer.call(__MODULE__, {:go_to_scoreboard, game_id})
  end

  # server

  # user join
  def handle_call({:user_joined, game_id, player_id}, _from, state) do
    game = Map.get(state, game_id, Game.new(game_id))
    new_player = Player.new(player_id)
    updated_game = Game.add_player(game, new_player)

    reply_with_updated_game(state, updated_game)
  end

  def handle_call({:start, game_id}, _from, state) do
    QuestionProvider.start_game(game_id)

    {:reply, :ok, state}
  end

  def handle_call({:next_question, game_id}, _from, state) do
    {:ok, question} = QuestionProvider.request_question(game_id)

    updated_game = Game.start_question(state[game_id], question)

    reply_with_updated_game(state, updated_game)
  end


  def handle_call({:add_fake_answer, game_id, player_id, answer}, _from, state) do
    updated_game = Game.add_fake_answer(state[game_id], player_id, answer)

    reply_with_updated_game(state, updated_game)
  end

  def handle_call({:answer_question, game_id, player_id, answer}, _from, state) do
    updated_game = Game.answer_question(state[game_id], player_id, answer)

    reply_with_updated_game(state, updated_game)
  end

  def handle_call({:go_to_question_result, game_id}, _from, state) do
    updated_game = Game.go_to_question_result(state[game_id])

    reply_with_updated_game(state, updated_game)
  end

  def handle_call({:go_to_scoreboard, game_id}, _from, state) do
    updated_game = Game.go_to_scoreboard(state[game_id])

    reply_with_updated_game(state, updated_game)
  end

  defp reply_with_updated_game(state, game) do
    updated_state = Map.put(state, game.id, game)

    {:reply, {:ok, game}, updated_state}
  end
end
