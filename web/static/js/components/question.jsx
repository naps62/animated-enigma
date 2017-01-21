import React from "react";
import _ from "lodash";

class Question extends React.Component {
  renderPlayer = (player) => {
    return <li key={player}>{player}</li>;
  }

  renderChairman() {
    return <div>Wait!</div>;
  }

  renderOther() {
    return <div>Do stuff!</div>;
  }

  render() {
    if (this.props.chairman) {
      return this.renderChairman();
    } else {
      return this.renderOther();
    }
  }
}

export default Question;
