import React from "react";

class Waiting extends React.Component {
import Presenter from "../presenter";

class ChairmanWaiting extends React.Component {
  componentDidMount() {
    Presenter.speak("Ay madre! Os mios amigos chamaram-me homossexual!");
    Presenter.speak("Bate lles!");
    Presenter.speak("Mas eles son tan fofos.");
  }

  render() {
    return <div className="Waiting">
      <div className="u-padDownLarge" />

      <h1 className="Text title">
        <div>- Ò māe, ò māe! Os meus amigos chamaram-me homossexual!</div>
        <div>- Bate-lhes</div>
        <div>- mas eles sao tao fofos.</div>
      </h1>
      <div className="u-pushDownLarge" />
    </div>
  }
}

export default Waiting;
