import { Socket } from "phoenix";
import ResponsiveVoice from "responsivevoice";

import Presenter from "./presenter";

class Client {
  constructor() {
    this.socket = new Socket("/socket", { params: { token: window.userToken } })
    this.socket.connect();
    this.state = null;
    this.stateListener = null;
  }

  onState(listener) {
    this.stateListener = listener;
  }

  join(gameId, playerId) {
    this.gameId = gameId;
    this.playerId = playerId;
    this.channel = this.socket.channel(`game:${gameId}`, {player_id: playerId});

    this.channel.join()
      .receive("ok", state => this._onJoin(state))
      .receive("error", this._onJoinError);

    this._setupEvents();
  }

  start() {
    this.channel.push("start", { game_id: this.gameId });
  }

  addFakeAnswer(answer) {
    this.channel.push("fake_answer", { game_id: this.gameId, player_id: this.playerId, answer: answer });
  }

  answerQuestion(answer) {
    this.channel.push("answer_question", { game_id: this.gameId, player_id: this.playerId, answer: answer });
  }

  _onJoin(initialState) {
    this._setState(initialState);
  }

  _onJoinError(error) {
    console.error(error);
  }

  _onPlayerJoined = ({ player_id: playerId }) => {
    if (this.playerId === playerId) {
      Presenter.welcome(playerId);
    } else {
      Presenter.userJoined(playerId);
    }
  }

  _onGameStart = ({ intro }) => {
    Presenter.speak(intro);
  }

  _setState = (state) => {
    this.state = state;
    if (this.stateListener) {
      this.stateListener(this.state);
    }
  }

  _setupEvents() {
    this.channel.on("game_update", this._setState);
    this.channel.on("game_start", this._onGameStart);
    this.channel.on("player_joined", this._onPlayerJoined);
  }
}

export default Client;
