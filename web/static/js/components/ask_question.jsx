import React from "react";
import _ from "lodash";

import Presenter from "../presenter";

class AskQuestion extends React.Component {
  componentDidMount () {
    Presenter.speak(this.props.question.question);
    _.each(this.answers, Presenter.speak);
  }

  get answers() {
    return this.props.question.all_answers;
  }

  handleChoice = (event) => {
    this.props.client.answerQuestion(event.target.innerHTML);
    event.preventDefault();
  }

  renderAnswer = (answer, index) => {
    return <button
      key={index}
      className="Button u-pushDownBase"
      onClick={this.handleChoice}
    >
      {answer}
    </button>
  }

  renderAnswers() {
    return <div className="AskQuestion-answers">
      {_.map(this.answers, this.renderAnswer)}
    </div>
  }

  render() {
    return <div className="AskQuestion">
      <div className="AskQuestion-content">
        <div className="u-padDownLarge" />

        <h1 className="Text title upper">{this.props.question.question}</h1>
        <div className="u-pushDownLarge" />

        {this.renderAnswers()}
      </div>
    </div>
  }
}

export default AskQuestion;
