import React from "react";
import _ from "lodash";

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

    this.props.client.addFakeAnswer(this.state.answer);

    this.setState({ submitted: true })
  }

  renderInput() {
    if (this.state.submitted) {
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

  renderSubmit() {
    if (this.state.submitted) {
      return <div className="Text">OK. Now hold one</div>;
    } else {
      return <button className="Button Button--other">Submit</button>;
    }
  }

  render() {
    return <div className="AnswerGatherer">
      <form onSubmit={this.handleSubmit} className="AnswerGatherer-form">
        <div className="u-pushDownLarge" />

        <h1 className="Text title upper">{this.props.question.question}</h1>
        <div className="u-pushDownLarge" />

        {this.renderInput()}
        <div className="u-pushDownLarge" />
        {this.renderSubmit()}
      </form>
    </div>
  }
}

export default AnswerGatherer;
