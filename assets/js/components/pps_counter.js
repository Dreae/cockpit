import { Controller } from 'stimulus';
import socket from "../socket";
import numeral from "numeral";

export default class PPSCounter extends Controller {
    connect() {
        let channel = socket.channel("dashboard:pps", {});
        channel.join()
            .receive("ok", (resp) => { console.log("Joined", resp); })
            .receive("error", (resp) => { console.error("Error joining", resp); });

        channel.on("pps_update", payload => {
            this.element.innerText = numeral(payload.pps).format('0,0') + ' PPS';
        });
    }
}
