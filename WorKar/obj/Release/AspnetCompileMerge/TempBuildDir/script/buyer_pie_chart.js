var ctx = document.getElementById('pie-chart').getContext('2d');
//ctx.height = 500;
var myChart = new Chart(ctx, {
    type: 'pie',
    data: {
        labels: ['Cancellation', 'Completion'],
        datasets: [{
            data: [500, 1000],
            backgroundColor: ['#ffd600', '#e91e63'],
            borderWidth: 1,
            borderColor: '#ddd'
        }]
    },
    options: {
        title: {
            display: true,
        },
        legend: {
            display: true
        },
        tooltips: {
            enabled: true
        },
        plugins: {
            datalabels: {
                display: true,
                align: 'bottom',
                backgroundColor: '#ccc',
                borderRadius: 3,
                font: {
                    size: 16,
                }
            },
        }
    }
});