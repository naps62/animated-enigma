import { Socket } from "phoenix"

let socket = new Socket("/socket", { params: { token: window.userToken } })

socket.connect();

let state = {};

// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("room:lobby", {})
channel.join()
  .receive("ok", initialState => {
    state = initialState;
    console.log("Joined successfully", initialState)
  })

  .receive("error", resp => {
    console.log("Unable to join", resp)
  })


let button = document.querySelector("button");
button.addEventListener("click", event => {
  channel.push("inc", { value: state.value })
});

channel.on("new_value", resp => {
  state = resp;
  console.log(resp);
  document.querySelector("#counter").innerHTML = state.value;
});


export default socket;
