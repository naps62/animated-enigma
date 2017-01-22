defmodule AnimatedEnigma.Game do
  defstruct id: nil, players: [], chairman: nil, state: :lobby, question: nil, result: nil, answer: nil, voice_text: nil

  alias AnimatedEnigma.{Question, Player, Intro}

  @correct_voice_texts [
    "Impecável, mesmo em cheio!",
    "Eu sei que vocês tinham que inserir as respostas erradas, mas não era preciso serem tão erradas!",
    "Se falhar fosse o teu trabalho, estavas desempregado!",
    "Mais um ponto para o menino da cadeira"
  ]

  @failure_voice_texts [
    "E acertou mesmo em cheio . . .na resposta submetida pelo #PLAYER",
    "Informo a todos os presentes que a resposta poderia estar certa, não tivesse sido o #PLAYER a submetê-la.",
    "Há coisas na vida que são certas, e acredito plenamente que o #PLAYER tem a certeza que esta era a resposta dele.",
    "Se um dia eu virar no caminho errado, vou-me lembrar desta resposta escolhida pelo #CHAIRMAN .",
    "Penso que quando viu a pergunta o #CHAIRMAN já sabia como isto ia acabar.",
    "Não sei se ficou claro nas regras, mas #CHAIRMAN o objetivo era escolher a resposta certa."
  ]

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

  def answer_question(game = %__MODULE__{question: question}, player_id, answer) do
    if Question.correct_answer?(question, answer) do
      game
      |> with_correct_answer(answer)
      |> increment_chairman_score(player_id)
    else
      game
      |> with_wrong_answer(answer)
      |> increment_other_score(answer)
    end
  end

  defp with_correct_answer(game, answer) do
    %__MODULE__{
      game |
      state: :authors,
      result: :correct,
      answer: answer,
      voice_text: Enum.random(@correct_voice_texts)
    }
  end

  defp with_wrong_answer(game, answer) do
    %__MODULE__{
      game |
      state: :authors,
      result: :wrong,
      answer: answer,
      voice_text: Enum.random(@failure_voice_texts)
    }
  end

  defp increment_chairman_score(%{players: players} = game, player_id) do
    updated_players = Enum.map(players, fn(current_player) ->
      if current_player.id == player_id do
        current_player |> Player.increment_score
      else
        current_player
      end
    end)

    %__MODULE__{game | players: updated_players}
  end

  defp increment_other_score(%{players: players, question: question} = game, answer) do
    player_id = Question.fake_answer_author_id(question, answer)

    updated_players = Enum.map(players, fn(current_player) ->
      if current_player.id == player_id do
        current_player |> Player.increment_score
      else
        current_player
      end
    end)

    %__MODULE__{game | players: updated_players}
  end

  def go_to_question_result(game) do
    %__MODULE__{game | state: :question_result}
  end

  def go_to_scoreboard(game) do
    %__MODULE__{game | state: :scoreboard}
  end
end
