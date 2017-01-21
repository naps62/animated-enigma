import "phoenix_html"

import React from "react";
import ReactDOM from "react-dom";
import Game from "./components/game";

const container = document.getElementById('game-container');

if (container) {
  const gameId = container.dataset.gameId;
  const playerId = container.dataset.playerId;

  ReactDOM.render(<Game id={gameId} playerId={playerId} />, document.getElementById("game-container"));
}

