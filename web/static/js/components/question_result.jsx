import React from "react";
import _ from "lodash";

class QuestionResult extends React.Component {
  get answers() {
    return this.props.question.all_answers;
  }

  playerIndex(answer) {
    const playerID = _.findKey(this.props.question.fake_answers, a => a == answer)

    return _.findIndex(this.props.players, { id: playerID });
  }

  classesForButton = (answer) => {
    return `Button withInnerContent player${this.playerIndex(answer)} u-pushDownBase`;
  }

  renderLeftContent(answer) {
    const index = this.playerIndex(answer);

    if (index == -1) {
      return;
    }

    const classes = `Avatar small player${index}`;

    return <div className="Button-leftContent">
      <div className={classes} />
    </div>;
  }

  renderRightContent(answer) {
    if (this.props.answer != answer) {
      return;
    }

    const classes = `Avatar small player0`;

    return <div className="Button-rightContent">
      <div className={classes} />
    </div>;
  }

  renderAnswer = (answer, index) => {
    return <button
      key={index}
      className={this.classesForButton(answer)}
    >
      {answer}
      {this.renderLeftContent(answer)}
      {this.renderRightContent(answer)}
    </button>
  }

  renderAnswers() {
    return <div className="QuestionResult-answers">
      {_.map(this.answers, this.renderAnswer)}
    </div>
  }

  render() {
    return <div className="QuestionResult">
      <div className="QuestionResult-content">
        <div className="u-padDownLarge" />

        <h1 className="Text title upper">{this.props.question.question}</h1>
        <div className="u-pushDownLarge" />

        {this.renderAnswers()}
      </div>
    </div>
  }
}

export default QuestionResult;
