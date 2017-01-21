import React from "react";
import _ from "lodash";

class Question extends React.Component {
  renderPlayer = (player) => {
    return <li key={player}>{player}</li>;
  }

  render() {
    return (
      <div>
        Question
      </div>
    );
  }
}

export default Question;
