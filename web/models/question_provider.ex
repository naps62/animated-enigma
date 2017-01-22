require IEx
defmodule AnimatedEnigma.QuestionProvider do
  use GenServer

  alias AnimatedEnigma.Question

  @questions [
    Question.new("Que país foi primeiro invadido pela Alemanha na Segunda Guerra Mundial?", "Polónia"),
    Question.new("Quem foi o famoso herói da guerra de Tróia, com um corpo invulnerável exceptuando uma parte?", "Aquiles"),
    Question.new("Qual foi o grande conflito iniciado em  1 de Setembro de 1939?", "Segunda Guerra Mundial"),
    Question.new("Quem foram as nações envolvidas na tragédia de Pearl Harbor?", "Estados Unidos e Japão"),
    Question.new("No ataque Japonês de Pearl Harbor, de onde veio o primeiro ataque?", "Ar"),
    Question.new("O assasinato de Francisco Fernando da Áustria-Hungria que despoletou a Primeira Guerra Mundial teve lugar em que País?", "Bósnia"),
    Question.new("Que evento levou os Estados Unidos a participarem na Segunda Guerra Mundial?", "Pearl Harbor"),
    Question.new("No dia 7 de Dezembro de 1941 aconteceu o ataque de Pearl Harbor, em que país?", "Havai"),
    Question.new("Qual foi o encontro em que Winston Churchill, Franklin Roosevelt e Joseph Stalin se juntaram para discutir a guerra", "Conferência de Yalta"),
    Question.new("Hitler era o líder Alemão durante a Segunda Guerra Mundial, quem era o presidente Italiano?", "Mussolini"),
    Question.new("Quem é que Hitler culpou pela derrota da Alemanha na Primeira Guerra Mundial?", "Judeus"),
    Question.new("Quem era o primeiro ministro Britânico durante grande parte da Segunda Guerra Mundial?", "Winston Churchill"),
    Question.new("Quem foi o adversário da França na Guerra dos 100 anos?", "Inglaterra"),
    Question.new("Quantas pessoas é que alguém tem que assassinar para ser considerado um serial killer?", "3"),
    Question.new("Qual é o nome do filme centrado num assassino em série que matava as vitimas de acordo com vários pecados?", "Se7en"),
    Question.new("Pedro López, suspeito de assassinar pelo menos 110 pessoas, foi libertado após ter sido obrigado a pagar uma fiança no valor de quantos dólares?", "50"),
    Question.new("Um serial killer dos anos 70, a meio da sua série de crimes foi encontrado numa situação peculiar,qual foi?", "Venceu um programa televisivo"),
    Question.new("Quantos anos de idade tinha pessoa mais nova a ser considerada um assassino em série?", "8"),
    Question.new("O que é que Robert Pickton também conhecido como pig farmer usava como silenciador?", "Um brinquedo sexual"),
    Question.new("Que banda famosa teve um dos seus membros questionados nos assassinatos em série Yorkshire Ripper devido à tour coincidir com eles?", "Joy Division"),
    Question.new("Qual era a profissão do assassino em série e fictício, marco do melodrama Victoriano e lenda urbana Londrina?", "Barbeiro"),
    Question.new("Jean-Baptiste Grenouille, assassino em série fictício do cinema, cometia os seus crimes para obter algo peculiar das suas vitimas, o que era?", "O seu perfume"),
    Question.new("Qual era o objeto irónico vendido pela empresa do assassino em série do Kansas ?", "Alarmes"),
    Question.new("O que fazia o assassino em série Richard Chase quando a porta de casa das vitimas estava trancada?", "Ia-se embora"),
    Question.new("John Wayne Gacy, famoso assassino em série fotografado com a primeira dama Americana utilizava frequentemente que tipo estranho de roupa?", "Roupa de Palhaço"),
    Question.new("Aileen Wuornos, a mais conhecida assassina em série Americana, era também famosa pelas suas?", "Pinturas"),
    Question.new("Em Maio de 2009, Jonathan Lee Riches processou a Guiness Book of Records para não o listarem como a pessoa com maior número de?", "Processos"),
    Question.new("Qual é a peculiaridade da patente das mundialmente usadas bocas de incêndio?", "A única cópia ardeu num incêndio"),
    Question.new("Qual era o tema dos mais de 80,000 botões de lapela foram recolhidos devido a conterem tinta tóxica e perigo em 1974?", "Sensibilização para a segurança"),
    Question.new("Quem foi o actor que entrou num concurso de personificação dele próprio e nem sequer chegou à fase final?", "Charlie Chaplin"),
    Question.new("Em 2007 um casal ficou conhecido devido a ter-se divorciado após descobrirem que a amante da Internet do marido era?", "A sua própria esposa"),
    Question.new("Qual é a peculiaridade do Santo Patrick, o padroeiro da Irlanda?", "Não é Irlandês"),
    Question.new("O que estava Ronaldinho Gaúcho a fazer quando a Coca-Cola decidiu terminar o seu contrato publicitário?", "A beber uma Pepsi"),
    Question.new("Existem várias coisas banidas na China, qual é a mais irónica de todas?", "A palavra censura"),
    Question.new("O que tinham em comum os advogados de defesa Donald Trump com os trabalhadores que o processaram?", "Salários em atraso"),
    Question.new("O que é que os criadores do slogan \"Pirataria é Crime\" utilizaram de peculiar no anúncio?", "Música pirateada"),
    Question.new("No dia 9 de Julho de 1993 Garry Hoy atirou-se contra uma janela do 24º andar para a sua morte, quais foram as suas últimas palavras?", "Não se preocupem, o vidro não parte"),
  ]

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def start_game(game_id) do
    GenServer.call(__MODULE__, {:start_game, game_id})
  end

  def request_question(game_id) do
    GenServer.call(__MODULE__, {:request_question, game_id})
  end

  def handle_call({:start_game, game_id}, _from, state) do
    new_state = Map.put(state, game_id, Enum.shuffle(@questions))

    {:reply, :ok, new_state}
  end

  def handle_call({:request_question, game_id}, _from, state) do
    case state[game_id] do
      [] ->
        {:reply, {:nope, "it's over bitch"}, state}

      [next_question | rest] ->
        new_state = %{state | game_id => rest}

        {:reply, {:ok, next_question}, new_state}
    end
  end
end
