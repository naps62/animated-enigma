import React from "react";
import _ from "lodash";

class Lobby extends React.Component {
  renderPlayer = (player, index) => {
    const avatarClasses = `Avatar large player${index}`;

    return <li className="Lobby-player" key={player.name}>
      <div className="Lobby-playerName">
        {player.name}
      </div>
      <div className={avatarClasses} />
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
    if (_.size(this.props.players) != this.props.roomSize) {
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
