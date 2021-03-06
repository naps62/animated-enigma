import React from "react";
import _ from "lodash";

import Client from "../client";
import Presenter from "../presenter";
import Lobby from "./lobby";
import AnswerGatherer from "./answer_gatherer";
import AskQuestion from "./ask_question";
import Waiting from "./waiting";
import Authors from "./authors";
import QuestionResult from "./question_result";
import MuteButton from "./mute_button";
import Scoreboard from "./scoreboard";

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
    state.isChairman = (state.chairman && state.chairman.id == this.props.playerId);
    state.index = _.findIndex(state.players, { id: this.props.playerId });
    state.playerId = this.props.playerId;

    return state;
  }

  onLobbyStart = () => {
    this.client.start();
  }

  renderAnswerGatherer() {
    if (this.state.isChairman) {
      return <Waiting {...this.state} />;
    } else {
      return <AnswerGatherer {...this.state} client={this.client} />;
    }
  }

  renderAskQuestion() {
    if (this.state.isChairman) {
      return <AskQuestion {...this.state} client={this.client} />;
    } else {
      return <Waiting {...this.state} />;
    }
  }

  renderAuthors() {
    return <Authors {...this.state} client={this.client} />;
  }

  renderQuestionResult() {
    return <QuestionResult {...this.state} client={this.client} />;
  }

  renderScoreboard() {
    return <Scoreboard {...this.state} client={this.client} />;
  }

  renderCurrentRoom() {
    switch(this.state.state) {
      case "lobby": return <Lobby {...this.state} roomSize={this.props.roomSize} onStart={this.onLobbyStart} />;
      case "gather_answers": return this.renderAnswerGatherer();
      case "asking_question": return this.renderAskQuestion();
      case "authors": return this.renderAuthors();
      case "question_result": return this.renderQuestionResult();
      case "scoreboard": return this.renderScoreboard();
      default: return <div>error. state is {this.state.state}.</div>;
    }
  }

  render() {
    const classes = `Game player${this.state.index}`;

    return <div className={classes}>
      {this.renderCurrentRoom()}
      <MuteButton />
    </div>
  }
}

export default Game;
