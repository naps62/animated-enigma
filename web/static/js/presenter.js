import ResponsiveVoice from "responsivevoice";

export const speak = (message) => {
  console.log(message);
  ResponsiveVoice.speak(message);
};

export const userJoined = (playerId) => {
  speak(`${playerId} juntou-se à festa`);
};

export const welcome = (playerId) => {
  speak(`Bem-vindo à festa ${playerId}`);
};

export default {
  speak,
  userJoined,
  welcome
};
