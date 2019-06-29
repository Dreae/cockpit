import {Socket} from "phoenix";

let socket = new Socket("/socket", {params: {token: window.socketToken}});

if (window.socketToken) {
  socket.connect();
}
let channel = socket.channel("dashboard:pps", {});
channel.join()
    .receive("ok", (resp) => { console.log("Joined", resp); })
    .receive("error", (resp) => { console.error("Error joining", resp); });

export const pps_channel = channel;

export default socket;
