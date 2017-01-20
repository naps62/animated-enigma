import React from "react";
import Client from "../client"

class Game extends React.Component {
  constructor(props) {
    super(props);
    this.client = new Client();
  }

  render() {
    return (
      <div>working</div>
    );
  }
}

export default Game;
