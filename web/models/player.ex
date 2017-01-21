defmodule AnimatedEnigma.Player do
  defstruct id: nil, name: nil, points: 0

  def new(name) do
    %__MODULE__{id: name, name: name}
  end
end
