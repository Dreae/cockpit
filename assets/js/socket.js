import {Socket} from "phoenix";

let socket = new Socket("/socket", {params: {token: window.socketToken}});

socket.connect();

export default socket;
