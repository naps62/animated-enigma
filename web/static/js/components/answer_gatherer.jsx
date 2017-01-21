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
  }

  render() {
    return <div className="AnswerGatherer">
      <form onSubmit={this.handleSubmit} className="AnswerGatherer-form">
        <div className="u-pushDownLarge" />

        <h1 className="Text title upper">{this.props.current_question}</h1>
        <div className="u-pushDownLarge" />

        <input
          type="text"
          value={this.state.answer}
          onChange={this.handleChange}
          className="Input"
          placeholder="Type your answer"
        />
        <div className="u-pushDownLarge" />

        <button className="Button Button--other">Submit</button>
      </form>
    </div>
  }
}

export default AnswerGatherer;
