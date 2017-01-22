import React from "react";
import _ from "lodash";

class Authors extends React.Component {
  get answers() {
    return this.props.question.all_answers;
  }

  skip = () => {
    if (!(this.props.chairman.id == this.props.playerId)) {
      return;
    }

    window.clearTimeout(this.state.timeout);
    this.props.client.goToQuestionResult();
  }

  componentDidMount() {
    // if we're the chairman, trigger the move to scoreboard
    this.setState({ timeout: window.setTimeout(this.skip, 5000) });
  }

  playerIndex(answer) {
    const playerId = _.findKey(this.props.question.fake_answers, a => a == answer)

    return _.findIndex(this.props.players, { id: playerId });
  }

  classesForButton = (answer) => {
    return `Button small withInnerContent player${this.playerIndex(answer)} u-pushDownBase`;
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
    return <div className="Authors-answers">
      {_.map(this.answers, this.renderAnswer)}
    </div>
  }

  render() {
    return <div className="Authors" onClick={this.skip}>
      <div className="Authors-content">
        <div className="u-padDownLarge" />

        <h1 className="Text title upper">{this.props.question.question}</h1>
        <div className="u-pushDownLarge" />

        {this.renderAnswers()}
      </div>
    </div>
  }
}

export default Authors;
