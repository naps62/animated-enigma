import React from "react";

import Presenter from "../presenter";

import Jokes from "../jokes";

class Waiting extends React.Component {
  constructor(props) {
    super(props);
    this.state = { joke: "" };
  }

  handleChangeJoke = () => {
    const joke = _.sample(Jokes);

    this.setState({ joke: joke });
    Presenter.speak(joke);
  }

  render() {
    return <div className="Waiting">
      <div className="u-padDownLarge" />
      <h1 className="Text title">
        Aguardando...
      </h1>
      <div className="u-pushDownBase" />

      <div className="Waiting-joke">
        {this.state.joke}
      </div>

      <div className="u-pushDownLarge" />

      <button className="Button" onClick={this.handleChangeJoke}>Estou aborrecido</button>
    </div>
  }
}

export default Waiting;
