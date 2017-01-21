import React from "react";
import _ from "lodash";

class Lobby extends React.Component {
  renderPlayer = (player) => {
    return <li className="Lobby-player" key={player.name}>
      <div className="Lobby-playerName">
        {player.name}
      </div>
    </li>;
  }

  renderPlayerList() {
    if (!this.props.players) {
      return;
    }

    return <ul className="Lobby-players">
      {_.map(this.props.players, this.renderPlayer)}
    </ul>;
  }

  renderStartButton() {
    if (_.size(this.props.players) != 4) {
      return;
    }

    return <div className="Lobby-startBtn">
      <button className="Button" onClick={this.props.onStart}>Start!</button>
    </div>
  }

  render() {
    return (
      <div className="Lobby">
        {this.renderPlayerList()}
        {this.renderStartButton()}
      </div>
    );
  }
}

export default Lobby;
