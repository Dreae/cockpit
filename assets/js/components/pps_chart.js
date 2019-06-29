import { Controller } from 'stimulus';
import { pps_channel } from "../socket";

export default class PPSChart extends Controller {
  connect() {
    pps_channel.on("pps_summary", this.handle_initial_query.bind(this));
    pps_channel.on("pps_update", this.update_chart.bind(this));

    pps_channel.push("pps_summary", null);
  }

  update_chart(payload) {
    console.log(this.chart);
    this.chart.data.labels.shift();
    this.chart.data.labels.push(payload.time);

    this.chart.data.datasets[0].data.shift();
    this.chart.data.datasets[0].data.push(payload.pps);

    this.chart.update();
  }

  handle_initial_query(payload) {
    var ctx = this.element.getContext('2d');
    this.chart = new Chart(ctx, {
      // The type of chart we want to create
      type: 'line',

      // The data for our dataset
      data: {
          labels: payload.values.map((value) => value[0]),
          datasets: [{
              label: 'Packets per Second',
              backgroundColor: 'rgb(255, 99, 132)',
              borderColor: 'rgb(255, 99, 132)',
              data: payload.values.map((value) => value[1])
          }]
      },

      // Configuration options go here
      options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          xAxes: [{
            type: 'time',
            ticks: {
              autoSkip: true,
              maxTicksLimit: 20
            }
          }]
        }
      }
    });
  }
}