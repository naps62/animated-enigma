import React from "react";

import Presenter from "../presenter";

import Jokes from "../jokes";

class Waiting extends React.Component {
  componentDidMount() {
    Presenter.speak("Ay madre! Os mios amigos chamaram-me homossexual!");
    Presenter.speak("Bate lles!");
    Presenter.speak("Mas eles son tan fofos.");
  }

  render() {
    return <div className="Waiting">
      <div className="u-padDownLarge" />

      <h1 className="Text title">
        <div>- Ó māe, ó māe! Os meus amigos chamaram-me homossexual!</div>
        <div>- Bate-lhes</div>
        <div>- Mas eles sao tao fofos.</div>
      </h1>
      <div className="u-pushDownLarge" />
    </div>
  }
}

export default Waiting;
