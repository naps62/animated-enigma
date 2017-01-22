import React from "react";

import Presenter from "../presenter";

class MuteButton extends React.Component {
  get text() {
    if (Presenter.isMuted()) {
      return "I'm lonely...";
    } else {
      return "Shut up!";
    }
  }

  handleClick = () => {
    Presenter.toggleMute();
    this.forceUpdate();
  }

  render () {
    return <div className="MuteButton" onClick={this.handleClick}>
      {this.text}
    </div>;
  }
}

export default MuteButton;
