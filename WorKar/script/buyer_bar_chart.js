let labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
let data = [5, 1, 17, 3, 2, 8, 2];

// Vertical bar chart
var ctx = document.getElementById('bar-chart');
ctx.height = 150;

var myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: labels,
        datasets: [{
            data: data,
            backgroundColor: [
                'rgba(240, 255, 0, 0.6)',
                'rgba(216, 27, 96, 0.6)',
                'rgba(3, 169, 244, 0.6)',
                'rgba(255, 152, 0, 0.6)',
                'rgba(29, 233, 182, 0.6)',
                'rgba(156, 39, 176, 0.6)',
                'rgba(84, 110, 122, 0.6)'
            ],
            borderColor: [
                '#ffd600',
                'rgba(216, 27, 96, 1)',
                'rgba(3, 169, 244, 1)',
                'rgba(255, 152, 0, 1)',
                'rgba(29, 233, 182, 1)',
                'rgba(156, 39, 176, 1)',
                'rgba(84, 110, 122, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        legend: {
            display: false
        },
        title: {
            display: true
        },
        scales: {
            yAxes: [{
                ticks: {
                    min: 0
                }
            }]
        },
        scales: {
            xAxes: [{
                gridLines: {
                    drawOnChartArea: false
                }
            }],
            yAxes: [{
                gridLines: {
                    drawOnChartArea: false
                }
            }]
        }
    }
});