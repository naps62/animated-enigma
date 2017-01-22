import React from "react";
import _ from "lodash";

import Presenter from "../presenter";

class QuestionResult extends React.Component {
  get answers() {
    return this.props.question.all_answers;
  }

  get voiceText() {
    const playerId = _.findKey(this.props.question.fake_answers, a => this.props.answer);
    const interpolatedChairman = _.replace(this.props.voice_text, /#CHAIRMAN/, this.props.chairman.id);
    const interpolatedPlayer = _.replace(interpolatedChairman, /#PLAYER/, playerId);

    return interpolatedPlayer;
  }

  skip = () => {
    if (!(this.props.chairman.id == this.props.playerId)) {
      return;
    }

    this.props.client.goToScoreboard();
  }

  componentDidMount() {
    Presenter.speak(this.voiceText);

    // if we're the chairman, trigger the move to scoreboard
    window.setTimeout(this.skip, 5000);
  }

  get rightText() {
    if (this.props.chairman.id == this.props.playerId) {
      return "Acertaste";
    } else {
      return "Acertou";
    }
  }

  get wrongText() {
    if (this.props.chairman.id == this.props.playerId) {
      return "Erraste";
    } else {
      return "Errou";
    }
  }

  get text() {
    if (this.props.result == "correct") {
      return this.rightText;
    } else {
      return this.wrongText;
    }
  }

  renderResult() {
    return <div className="QuestionResult-innerContent">
      <div className="Avatar large player0" />
      <div className="u-padDownLarge" />
      <div className="QuestionResult-text">{this.text}</div>
    </div>
  }

  render() {
    return <div className="QuestionResult" onClick={this.skip}>
      <div className="QuestionResult-content">
        <div className="u-padDownLarge" />

        {this.renderResult()}
      </div>
    </div>
  }
}

export default QuestionResult;
