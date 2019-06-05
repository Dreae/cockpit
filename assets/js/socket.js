import {Socket} from "phoenix";

let socket = new Socket("/socket", {params: {token: window.socketToken}});

socket.connect();

// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("dashboard:pps", {})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) });

channel.on("pps_update", payload => {
  console.log(payload);
});

export default socket;
