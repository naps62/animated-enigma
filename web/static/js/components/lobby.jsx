import React from "react";
import _ from "lodash";

class Lobby extends React.Component {
  renderPlayer = (player) => {
    return <li key={player}>{player}</li>;
  }

  renderPlayerList() {
    if (!this.props.players) {
      return;
    }

    return <ul>
      {_.map(this.props.players, this.renderPlayer)}
    </ul>;
  }

  renderStartButton() {
    if (this.props.players.length != 2) {
      return;
    }

    return <button onClick={this.props.onStart}>Start!</button>
  }

  render() {
    return (
      <div>
        gameId: {this.props.game_id}
        <br />
        you: {this.props.game_id}
        <br />
        {this.renderPlayerList()}
        {this.renderStartButton()}
      </div>
    );
  }
}

export default Lobby;
