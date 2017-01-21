import "phoenix_html"

import _ from "lodash";
import React from "react";
import ReactDOM from "react-dom";

import Game from "./components/game";

class App {
  constructor () {
    console.log("Initializing application");
    this.checkLoadingStateInterval = window.setInterval(this.checkLoadingState, 100);
  }

  checkLoadingState = () => {
    console.log("Checking load state");
    if (this.isReady()) {
      clearInterval(this.checkLoadingStateInterval);
      this.run();
    }
  }

  isReady() {
    return this.isVoiceReady();
  }

  isVoiceReady() {
    const browserVoices = window.speechSynthesis ? window.speechSynthesis.getVoices() : [];

    return !_.isEmpty(browserVoices) || !_.isEmpty(ResponsiveVoice.systemvoices);
  }

  run () {
    console.log("Running");
    const container = document.getElementById('game-container');

    if (container) {
      const gameId = container.dataset.gameId;
      const playerId = container.dataset.playerId;

      ReactDOM.render(<Game id={gameId} playerId={playerId} />, container);
    }
  }
}

window.AnimatedEnigma = new App();
