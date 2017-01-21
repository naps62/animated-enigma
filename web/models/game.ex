defmodule AnimatedEnigma.Game do
  defstruct id: nil, players: [], chairman: nil, state: :lobby, question: nil

  alias AnimatedEnigma.Question

  def new(game_id) do
    %__MODULE__{id: game_id}
  end

  def add_player(game = %__MODULE__{players: []}, player) do
    %__MODULE__{
      game |
      players: [player],
      chairman: player
    }
  end

  def add_player(game = %__MODULE__{players: players}, player) do
    %__MODULE__{
      game |
      players: Enum.uniq(players ++ [player])
    }
  end

  def start_question(game, question) do
    %__MODULE__{
      game |
      state: :gather_answers,
      question: question
    }
  end

  def add_fake_answer(game = %__MODULE__{question: question}, player, answer) do
    %__MODULE__{
      game |
      question: Question.add_fake_answer(question, player, answer)
    }
  end
end
