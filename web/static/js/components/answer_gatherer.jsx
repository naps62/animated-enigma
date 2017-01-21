import React from "react";
import _ from "lodash";

class AnswerGatherer extends React.Component {
  render() {
    return <div className="AnswerGatherer">
      <div className="AnswerGatherer-form">
        <div className="u-pushDownLarge" />

        <div className="AnswerGatherer-question">{this.props.current_question}</div>

        <div className="u-pushDownLarge" />

        <input type="text" className="Input" placeholder="Type your answer" />

        <div className="u-pushDownLarge" />

        <button className="Button Button--other">Submit</button>
      </div>
    </div>
  }
}

export default AnswerGatherer;
