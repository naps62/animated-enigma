import React from "react";
import _ from "lodash";

import Presenter from "../presenter";
import Fooling from "./fooling";

class AnswerGatherer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {answer: ''};
  }

  handleChange = (event) => {
    this.setState({ answer: event.target.value });
  }

  handleSubmit = (e) => {
    e.preventDefault();

    if (this.isCorrectAnswer()) {
      const message = "Parabéns, escreveste a resposta correcta. Mas o objectivo não é esse, portanto esforça-te mais."

      Presenter.speak(message);
      this.setState({ error: message });
    } else {
      this.props.client.addFakeAnswer(this.state.answer);

      this.setState({ submitted: true })
    }
  }

  isCorrectAnswer() {
    const normalizedSubmitted = _.lowerCase(_.replace(this.state.answer, /\s+/g, ""));
    const normalizedCorrect = _.lowerCase(_.replace(this.props.question.correct_answer, /\s+/g, ""));
    console.log("> Normalized submitted:", normalizedSubmitted);
    console.log("> Normalized correct:", normalizedCorrect);

    return normalizedSubmitted === normalizedCorrect;
  }

  isSubmitted() {
    return this.props.question.fake_answers[this.props.client.playerId];
  }

  renderInput() {
    if (this.isSubmitted()) {
      return;
    }

    return <input
      type="text"
      value={this.state.answer}
      onChange={this.handleChange}
      className="Input"
      placeholder="Type your answer"
    />;
  }

  renderError() {
    if (!this.state.error) return null;

    return <div>
      <div className="Text">{this.state.error}</div>
      <div className="u-pushDownLarge" />
    </div>;
  }

  renderSubmit() {
    if (this.isSubmitted()) {
      return <div className="Text">OK. Now hold one</div>;
    } else {
      return <button className="Button Button--other">Submit</button>;
    }
  }

  render() {
    return <div className="AnswerGatherer">
      <Fooling {...this.props} />
      <form onSubmit={this.handleSubmit} className="AnswerGatherer-form">
        <div className="u-pushDownLarge" />

        <h1 className="Text title upper">{this.props.question.question}</h1>
        <div className="u-pushDownLarge" />

        {this.renderInput()}
        {this.renderError()}
        <div className="u-pushDownLarge" />
        {this.renderSubmit()}
      </form>
    </div>
  }
}

export default AnswerGatherer;
