import socket from "./socket";
import UIkit from "uikit";
import Icons from "uikit/dist/js/uikit-icons";
import turbolinks from "turbolinks";
import { Application } from "stimulus";
import PPSCounter from "./components/pps_counter";
import "../sass/app.scss";
import PPSChart from "./components/pps_chart";

UIkit.use(Icons);
turbolinks.start();

const application = new Application();
application.register("pps-counter", PPSCounter);
application.register("pps-chart", PPSChart);
application.start();

// TODO: Better way to handle these
window.UIkit = UIkit;
window.socket = socket;
