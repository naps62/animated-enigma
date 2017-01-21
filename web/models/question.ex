defmodule AnimatedEnigma.Question do
  defstruct question: nil, correct_answer: nil, fake_answers: []

  def new(question, correct_answer) do
    %__MODULE__{question: question, correct_answer: correct_answer}
  end
end
