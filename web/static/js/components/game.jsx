import React from "react";
import Client from "../client";
import Lobby from "./lobby";
import AnswerGatherer from "./answer_gatherer";
import _ from "lodash";

class Game extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
    this.client = new Client();
  }

  componentWillMount() {
    this.client.onState(state => {
      this.setState(this.decoratedState(state))
    });
    this.client.join(this.props.id, this.props.playerId);
  }

  decoratedState = (state) => {
    state.chairman = (state.chairman == this.props.playerId);
    state.index = _.indexOf(state.players, this.props.playerId);

    return state;
  }

  onLobbyStart = () => {
    this.client.start();
  }

  renderAnswerGatherer() {
    if (this.state.chairman()) {
      return <div>Wait!</div>;
    } else {
      return <AnswerGatherer {...this.state} />;
    }
  }

  renderCurrentRoom() {
    switch(this.state.state) {
      case "lobby": return <Lobby {...this.state} onStart={this.onLobbyStart} />;
      case "gather_answers": renderAnswerGatherer();
      default: return <div>error. state is {this.state.state}.</div>;
    }
  }

  render() {
    const classes = `Game player${this.state.index}`;

    return <div className={classes}>
      {this.renderCurrentRoom()}
    </div>
  }
}

export default Game;
