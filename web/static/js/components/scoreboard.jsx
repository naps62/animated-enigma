import React from "react";
import _ from "lodash";

class Scoreboard extends React.Component {
  skip = () => {
    if (!(this.props.chairman.id == this.props.playerId)) {
      return;
    }

    window.clearTimeout(this.state.timeout);
    this.props.client.goToNextQuestion();
  }

  componentDidMount() {
    // if we're the chairman, trigger the move to scoreboard
    this.setState({ timeout: window.setTimeout(this.skip, 5000) });
  }

  renderScore(player, index) {
    const avatarClasses = `Avatar small player${index}`;

    return <div
      key={player.id}
      className="Scoreboard-player"
    >
      <div className="Scoreboard-avatar">
        <div className={avatarClasses} />
      </div>

      <div className="Scoreboard-name">
        {player.name}
      </div>

      <div className="Scoreboard-score">
        {player.score}/7
      </div>
    </div>
  }

  renderScores() {
    return _.map(this.props.players, this.renderScore);
  }

  render() {
    return <div className="Scoreboard" onClick={this.skip}>
      <div className="Scoreboard-content">
        <div className="u-padDownLarge" />

        <h1 className="Text title upper">Pontuaçāo</h1>
        <div className="u-pushDownLarge" />

        {this.renderScores()}
      </div>
    </div>;
  }
}

export default Scoreboard;
