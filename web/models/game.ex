defmodule AnimatedEnigma.Game do
  defstruct id: nil, players: [], chairman: nil, state: :lobby, current_question: nil

  def new(game_id) do
    %__MODULE__{id: game_id}
  end

  def add_player(game = %__MODULE__{players: []}, player) do
    %__MODULE__{game | players: [player], chairman: player}
  end

  def add_player(game = %__MODULE__{players: players}, player) do
    %__MODULE__{game | players: players ++ [player]}
  end

  def start_question(game, question) do
    %__MODULE__{game | state: :gather_answers, current_question: question}
  end
end
