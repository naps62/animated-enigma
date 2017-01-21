defmodule AnimatedEnigma.Question do
  defstruct question: nil, correct_answer: nil, fake_answers: %{}

  def new(question, correct_answer) do
    %__MODULE__{question: question, correct_answer: correct_answer}
  end

  def add_fake_answer(question = %__MODULE__{fake_answers: fake_answers}, player, answer) do
    %__MODULE__{
      question |
      fake_answers: Map.put(fake_answers, player, answer)
    }
  end
end
