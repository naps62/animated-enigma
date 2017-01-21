import React from "react";
import _ from "lodash";

class AskQuestion extends React.Component {
  render() {
    return <div className="AskQuestion">
      <form onSubmit={this.handleSubmit} className="AskQuestion-form">
        <div className="u-pushDownLarge" />

        <h1 className="Text title upper">{this.props.question.question}</h1>
        <div className="u-pushDownLarge" />

      </form>
    </div>
  }
}

export default AskQuestion;
