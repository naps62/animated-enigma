import React from "react";
import _ from "lodash";

class QuestionResult extends React.Component {
  get answers() {
    return this.props.question.all_answers;
  }

  classesForButton = (answer) => {
    const playerID = _.findKey(this.props.question.fake_answers, a => a == answer)
    const playerIndex = _.findIndex(this.props.players, { id: playerID });

    return `Button player${playerIndex} u-pushDownBase`
  }

  renderAnswer = (answer, index) => {
    return <button
      key={index}
      className={this.classesForButton(answer)}
    >
      {answer}
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
