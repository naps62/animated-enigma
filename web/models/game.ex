defmodule AnimatedEnigma.Game do
  defstruct id: nil, players: [], chairman: nil, state: :lobby, question: nil, result: nil

  alias AnimatedEnigma.Question

  def new(game_id) do
    %__MODULE__{id: game_id}
  end

  def add_player(game = %__MODULE__{players: []}, player) do
    %__MODULE__{
      game |
      players: [player],
      chairman: player,
    }
  end

  def add_player(game = %__MODULE__{players: players}, player) do
    IO.inspect players
    %__MODULE__{
      game |
      players: Enum.uniq(players ++ [player]),
    }
  end

  def start_question(game, question) do
    %__MODULE__{
      game |
      state: :gather_answers,
      question: question
    }
  end

  def add_fake_answer(game = %__MODULE__{question: question}, player_id, answer) do
    %__MODULE__{
      game |
      question: Question.add_fake_answer(question, player_id, answer)
    }
    |> with_updated_status
  end

  defp with_updated_status(game) do
    if Question.ready?(game.question) do
      %__MODULE__{game | state: :asking_question }
    else
      game
    end
  end

  def answer_question(game = %__MODULE__{question: question}, player, answer) do
    if Question.correct_answer?(question, answer) do
      with_correct_answer(game, player)
    else
      with_wrong_answer(game, answer)
    end
  end

  def with_correct_answer(game, _player) do
    %__MODULE__{game | state: :question_result, result: :correct}
  end

  def with_wrong_answer(game, _player) do
    %__MODULE__{game | state: :question_result, result: :wrong}
  end
end
