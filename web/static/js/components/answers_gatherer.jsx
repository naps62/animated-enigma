import React from "react";
import _ from "lodash";

class AnswersGatherer extends React.Component {
  render() {
    return <div className="AnswersGatherer">
      <div>{this.props.current_question}</div>;
    </div>
  }
}

export default AnswersGatherer;
