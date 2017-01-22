import "phoenix_html"

import _ from "lodash";
import React from "react";
import ReactDOM from "react-dom";
import ResponsiveVoice from "responsivevoice";

import Presenter from "./presenter";
import Game from "./components/game";

class App {
  constructor () {
    this.voiceReady = false;

    this.checkLoadingStateInterval = window.setInterval(this.checkLoadingState, 100);

    ResponsiveVoice.AddEventListener("OnReady", this.handleVoiceReady);
  }

  checkLoadingState = () => {
    if (this.isReady()) {
      clearInterval(this.checkLoadingStateInterval);

      this.init();
      this.run();
    }
  }

  handleVoiceReady = () => {
    this.voiceReady = true;
  }

  isReady() {
    return this.voiceReady;
  }

  init () {
    Presenter.init({ silentMode: true });
  }

  run () {
    const container = document.getElementById('game-container');

    if (container) {
      const gameId = container.dataset.gameId;
      const playerId = container.dataset.playerId;
      const roomSize = container.dataset.roomSize;

      ReactDOM.render(<Game id={gameId} playerId={playerId} roomSize={roomSize} />, container);
    }
  }
}

window.AnimatedEnigma = new App();
