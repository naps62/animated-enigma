defmodule AnimatedEnigma.Question do
  import AnimatedEnigma.Config

  defstruct question: nil, correct_answer: nil, fake_answers: %{}, all_answers: []

  def new(question, correct_answer) do
    %__MODULE__{question: question, correct_answer: correct_answer, all_answers: [correct_answer]}
  end

  def add_fake_answer(question = %__MODULE__{fake_answers: fake_answers, all_answers: all_answers}, player, answer) do
    updated_question = %__MODULE__{
      question |
      fake_answers: Map.put(fake_answers, player, answer),
      all_answers: Enum.shuffle(all_answers ++ [answer])
    }
  end

  def ready?(question) do
    IO.inspect room_size()
    Enum.count(question.fake_answers) == room_size() - 1
  end

  def correct_answer?(question, answer) do
    question.correct_answer == answer
  end
end
