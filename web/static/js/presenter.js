import ResponsiveVoice from "responsivevoice";
import _ from "lodash";

const config = {
  silentMode: false
};

const intros = [
  `Hola. Sejam bem vindos ao Ma Onda, o melhor jogo browser de perguntas e
  respostas que eu já tive o prazer de apresentar.`,
];

export const init = ({ silentMode }) => {
  config.silentMode = silentMode;

  ResponsiveVoice.setDefaultVoice("Spanish Female");
}

export const speak = (message) => {
  console.log(message);

  if (config.silentMode) return;

  ResponsiveVoice.speak(message);
};

export const intro = () => {
  const intro = _.sample(intros);
  speak(intro);
}

export const userJoined = (playerId) => {
  speak(`${playerId} juntou-se à festa`);
};

export const welcome = (playerId) => {
  speak(`Bem-vindo à festa ${playerId}`);
};

export default {
  init,
  intro,
  speak,
  userJoined,
  welcome
};
