import React from "react";
import Client from "../client";
import _ from "lodash";

class Game extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
    this.client = new Client();
  }

  componentWillMount() {
    this.client.onState(state => this.setState(state));
    this.client.join(this.props.id, this.props.playerId);
  }

  renderPlayer(player) {
    return <li key={player.public_id}>{player.public_id}</li>;
  }

  renderPlayerList() {
    if (!this.state.players) {
      return;
    }

    return <ul>
      {_.map(this.state.players, this.renderPlayer)}
    </ul>;
  }

  render() {
    return (
      <div>
        {this.renderPlayerList()}
        gameId: {this.props.id}
        <br />
        playerId: {this.props.playerId}
      </div>
    );
  }
}

export default Game;
