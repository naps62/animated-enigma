import React from "react";
import Client from "../client";
import Lobby from "./lobby";
import Question from "./question";
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
    console.log(state, this.props.playerId)

    return state;
  }

  onLobbyStart = () => {
    this.client.start();
  }

  render() {
    switch(this.state.state) {
      case "lobby": return <Lobby {...this.state} onStart={this.onLobbyStart} />;
      case "running": return <Question {...this.state} onStart={this.onLobbyStart} />;
      default: return <div>error. state is {this.state.state}.</div>;
    }
  }
}

export default Game;
