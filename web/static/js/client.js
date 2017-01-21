import { Socket } from "phoenix";

class Client {
  constructor() {
    this.socket = new Socket("/socket", { params: { token: window.userToken } })
    this.socket.connect();
    this.state = null;
    this.stateListener = null;
  }

  onState(listener) {
    this.stateListener = listener;
  }

  join(gameId, playerId) {
    this.channel = this.socket.channel(`game:${gameId}`, {player_id: playerId});

    this.channel.join()
      .receive("ok", state => this._onJoin(state))
      .receive("error", this._onJoinError);
  }

  _onJoin(initialState) {
    this._setState(initialState);
    console.info("Joined successfully", this.state)
  }

  _onJoinError(error) {
    console.error(error);
  }

  _setState(state) {
    this.state = state;
    if (this.stateListener) {
      this.stateListener(this.state);
    }
  }
}

export default Client;
