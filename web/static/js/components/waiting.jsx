import React from "react";

import Presenter from "../presenter";

class Waiting extends React.Component {
  componentDidMount() {
    Presenter.speak("Ay madre! Os mios amigos chamaram-me homossexual!");
    Presenter.speak("Bate lles!");
    Presenter.speak("Mas eles son tan fofos.");
  }

  render() {
    return <div className="Waiting">
      <div className="u-padDownLarge" />

      <h1 className="Text title">
        <div>- Ó māe, ó māe! Os meus amigos chamaram-me homossexual!</div>
        <div>- Bate-lhes</div>
        <div>- Mas eles sao tao fofos.</div>
      </h1>
      <div className="u-pushDownLarge" />
    </div>
  }
}

JOKES = [
  "Diz o que quiseres das pessoas surdas. NSFW",
  "Eu expliquei ao meu Médico que parti o braço em dois sítios. Ele disseme para parar de lá ir.",
  "1 em cada 7 anões é o rabugento.",
  "Grita alto para as pessoas que querem saber o contrário de baixo.",
  "O meu avô tem um coração de Leão e uma proibição de voltar ao jardim zoológico.",
  "Estou viciado em óleo dos travões, mas posso parar quando quiser.",
  "Fui numa aventura de uma vez numa vida. Nunca mais.",
  "Este tipo com ejaculação precoce veio do nada. NSFW",
  "Não odeias pessoas que respondem perguntas retóricas? Eu odeio.",
  "Dois peixes estavam num tanque, nenhum o sabia conduzir.",
  "O meu médico disse que eu tinha que parar de me masturbar, eu perguntei porquê? Ele disse que estava a interromperlhe a consulta. NSFW",
  "O meu avô perdeu a língua na guerra, mas nunca nos falou do assunto.",
  "Três palavras para me descrever? Preguiçoso.",
  "Como se chama um bumerangue que não volta? Pau.",
  "A minha mulher pediume para lhe dizer coisas porcas, eu gritei: “A LOIÇA”.",
  "”Qual é o teu ponto fraco?”  Honestidade.  “Não acho isso um ponto fraco”  Quero lá saber do que tu achas.",
  "Ouviste falar do Homem com 5 pénis? Os preservativos servemlhe como uma luva. NSFW",
  "Os adeptos do sexo oral gabamno de boca cheia. NSFW",
  "Sempre que tiveres frio sentate num canto, lá são 90 graus.",
  "Não sou viciado em cocaína, só gosto do cheiro. NSFW",
  "A sally não tem braços. Truz Truz...Não é a Sally NSFW",
  "Os piratas congelados são homens duros de roer.",
  "Inspecionar espelhos é um trabalho que eu me veria a fazer.",
  "Doutor, sempre que toco em qualquer parte do meu corpo dói, terei partido alguma coisa? Sim, o dedo.",
  "Eu era uma pessoa indecisa, agora não tenho a certeza.",
  "Qual é a parte mais difícil de mastigar de um vegetal? A cadeira de rodas. NSFW",
]

export default Waiting;
