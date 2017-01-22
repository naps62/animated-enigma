defmodule AnimatedEnigma.Player do
  defstruct id: nil, name: nil, score: 0

  def new(name) do
    %__MODULE__{id: name, name: name}
  end

  def increment_score(%{score: score} = player) do
    %__MODULE__{player | score: score + 1}
  end
end
