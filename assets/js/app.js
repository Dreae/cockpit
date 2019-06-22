import socket from "./socket";
import UIkit from "uikit";
import Icons from "uikit/dist/js/uikit-icons";

import "../sass/app.scss"

UIkit.use(Icons);

// TODO: Better way to handle these
window.UIkit = UIkit;
window.socket = socket;

// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("dashboard:pps", {})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) });

// TODO: Better way to handle this
channel.on("pps_update", payload => {
    let ppsCounter = document.getElementById("pps-counter");
    if (ppsCounter) {
        let ppsString = payload.pps.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        ppsCounter.innerText = `${ppsString} PPS`;
    }
});

var ctx = document.getElementById('pps_chart').getContext('2d');
new Chart(ctx, {
    // The type of chart we want to create
    type: 'line',

    // The data for our dataset
    data: {
        labels: ['15:00', '15:10', '15:20', '15:30', '15:40', '15:50', '15:60'],
        datasets: [{
            label: 'Packets per Second',
            backgroundColor: 'rgb(255, 99, 132)',
            borderColor: 'rgb(255, 99, 132)',
            data: [0, 10, 5, 2, 20, 30, 45]
        }]
    },

    // Configuration options go here
    options: {
        responsive: true,
        maintainAspectRatio: false
    }
});