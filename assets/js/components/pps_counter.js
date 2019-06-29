import { Controller } from 'stimulus';
import { pps_channel } from "../socket";
import numeral from "numeral";

export default class PPSCounter extends Controller {
  connect() {
    pps_channel.on("pps_update", payload => {
      this.element.innerText = numeral(payload.pps).format('0,0') + ' PPS';
    });
  }
}
