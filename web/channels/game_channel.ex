defmodule AnimatedEnigma.GameChannel do
  use Phoenix.Channel

  alias AnimatedEnigma.GameManager

  @intros [
    "Hola. Sejam bem vindos ao Ma Onda, o melhor jogo browser de perguntas e
    respostas que eu já tive o prazer de apresentar.",
    "Bem vindos! Meu nome é Maria Isabella Valentina Emanuela Branco Maia
    Gonçalves Fernandes da Costa. Serei a vossa apresentadora durante esta
    sessão.",
    "Senhores e senhoras! Meninos e meninas! Eu chamo-me Maria, sou uma pequena
    espanhola com um sonho, ser uma estrela de televisão. Depois de muitos
    castings, muitas entrevistas e muitas tentativas falhadas, estive quase a
    desistir, mas por mim, pelas minhas pequenitas e pela exaltação da comunidade
    hispânica em Portugal eu não desisti. Continuei a tentar e finalmente
    consegui, um lugar como apresentadora do Má Onda. Não irei desperdiçar esta
    oportunidade, irei ser profissional, e serei a melhor apresentadora alguma
    vez vista, não vou mandar piadas desnecessárias, não vou fazer como as
    jornalistas e falar da minha vida pessoal durante o programa, não vou
    aborrecer os participantes com introduções desnecessárias, não vou gastar
    tempo à produção com falas sem qualquer tipo de destino e conversas sem
    possibilidade de produção. Portanto, agradeço desde já a oportunidade e a
    presença de todos vocês, por ouvirem a minha apresentação feita na minha
    maravilhosa voz, divirtam-se a responder a perguntas enquanto o público
    volta os olhos para mim, a estrela deste programa, a Maria Isabella
    Valentina Emanuela Branco Maia Gonçalves Fernandes da Costa.Senhores e
    senhoras! Meninos e meninas! Eu chamo-me Maria, sou uma pequena espanhola
    com um sonho, ser uma estrela de televisão. Depois de muitos castings,
    muitas entrevistas e muitas tentativas falhadas, estive quase a desistir,
    mas por mim, pelas minhas pequenitas e pela exaltação da comunidade hispânica
    em Portugal eu não desisti. Continuei a tentar e finalmente consegui, um
    lugar como apresentadora do Má Onda. Não irei desperdiçar esta oportunidade,
    irei ser profissional, e serei a melhor apresentadora alguma vez vista,
    não vou mandar piadas desnecessárias, não vou fazer como as jornalistas e
    falar da minha vida pessoal durante o programa,não vou aborrecer os
    participantes com introduções desnecessárias, não vou gastar tempo
    à produção com falas sem qualquer tipo de destino e conversas sem
    possibilidade de produção. Portanto, agradeço desde já a oportunidade e a
    presença de todos vocês, por ouvirem a minha apresentação feita na minha
    maravilhosa voz, divirtam-se a responder a perguntas enquanto o público
    volta os olhos para mim, a estrela deste programa.",
    "Cá está a hora! O momento mais esperado! Coloquem o cinto, metam o capacete
    e acabem a vossa viagem de mota antes de utilizarem o telemóvel para começar
    uma nova partida do Má Onda, o vosso jogo de perguntas e respostas não
    familiar!",
    "Apenas tem 3 amigos? Está a planear mantê-los? Este não é o jogo certo!
    Prepare-se para sabotar qualquer um deles nas mais variadas ocasiões no novo
    concurso de perguntas e respostas de horário nobre da Internet, o Má Onda!",
    "Bem vindos e obrigado por escolherem o Má Onda! A sua versão gratuita acaba
    por aqui, para continuar aguarde enquanto vou ler uma mensagem dos nossos
    patrocinadores: sinal de menor ponto de exclamação traço traço. colocar aqui
    mensagem do patrocinador quando o tivermos. traço traço sinal de maior."
  ]


  def join("game:" <> game_id, %{"player_id" => player_id} = _payload, socket) do
    case GameManager.user_joined(game_id, player_id) do
      {:ok, game} ->
        send self(), {:update_game_state, game}
        send self(), {:player_joined, player_id}
        {:ok, socket}

      {:error, reason} ->
        {:error, %{reason: reason}}
    end
  end

  def handle_in("start", %{"game_id" => game_id}, socket) do
    case GameManager.start(game_id) do
      {:ok, game} ->
        send self(), {:game_start, Enum.random(@intros)}
        send self(), {:update_game_state, game}

      _ -> nil
    end
  end

  def handle_in("next_question", %{"game_id" => game_id}, socket) do
    GameManager.next_question(game_id)
    |> handle_game_update(socket)
  end

  def handle_in("fake_answer", %{"game_id" => game_id, "player_id" => player_id, "answer" => answer }, socket) do
    GameManager.add_fake_answer(game_id, player_id, answer)
    |> handle_game_update(socket)
  end

  def handle_in("answer_question", %{"game_id" => game_id, "player_id" => player_id, "answer" => answer }, socket) do
    GameManager.answer_question(game_id, player_id, answer)
    |> handle_game_update(socket)
  end

  def handle_in("go_to_question_result", %{"game_id" => game_id}, socket) do
    GameManager.go_to_question_result(game_id)
    |> handle_game_update(socket)
  end

  def handle_in("go_to_scoreboard", %{"game_id" => game_id}, socket) do
    GameManager.go_to_scoreboard(game_id)
    |> handle_game_update(socket)
  end

  defp handle_game_update({:ok, game}, socket) do
    send self(), {:update_game_state, game}
    {:noreply, socket}
  end

  defp handle_game_update(_, socket) do
    {:noreply, socket}
  end


  def handle_info({:update_game_state, game}, socket) do
    IO.inspect game
    broadcast! socket, "game_update", game
    {:noreply, socket}
  end

  def handle_info({:game_start, intro}, socket) do
    IO.inspect intro
    broadcast! socket, "game_start", %{ intro: intro }
    {:noreply, socket}
  end

  def handle_info({:player_joined, player_id}, socket) do
    broadcast! socket, "player_joined", %{ player_id: player_id }
    {:noreply, socket}
  end
end
