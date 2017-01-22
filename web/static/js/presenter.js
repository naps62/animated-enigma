import ResponsiveVoice from "responsivevoice";
import _ from "lodash";

const config = {
  silentMode: false
};

export const init = ({ silentMode }) => {
  config.silentMode = silentMode;

  ResponsiveVoice.setDefaultVoice("Spanish Female");
}

export const speak = (message) => {
  console.log(message);

  if (config.silentMode) return;

  ResponsiveVoice.speak(message);
};

export const userJoined = (playerId) => {
  speak(`${playerId} juntou-se à festa`);
};

export const welcome = (playerId) => {
  speak(`Bem-vindo à festa ${playerId}`);
};

export default {
  init,
  speak,
  userJoined,
  welcome
};
