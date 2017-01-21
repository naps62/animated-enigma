import React from "react";
import _ from "lodash";

class AnswerGatherer extends React.Component {
  render() {
    return <div className="AnswerGatherer">
      <div>{this.props.current_question}</div>;
    </div>
  }
}

export default AnswerGatherer;
