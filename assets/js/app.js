import socket from "./socket"

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