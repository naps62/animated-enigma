import React from "react";
import _ from "lodash";

class Fooling extends React.Component {
  render() {
    return <div className="Fooling">
      Fooling {this.props.chairman.name}
      <div className="u-pushRightBase" />
      <div className="Avatar small player0" />
    </div>
  }
}

export default Fooling;
