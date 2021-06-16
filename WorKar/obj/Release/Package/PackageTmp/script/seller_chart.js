function drawChart(divId) {
    let labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    let data = [5, 1, 17, 3, 2, 8, 2];


    let chart_ele = document.getElementById(divId).getContext('2d');

    var chart = new Chart(chart_ele, {
        // The type of chart we want to create
        type: 'line',

        // The data for our dataset
        data: {
            labels: labels,
            datasets: [{
                label: 'Orders In Week Days',
                backgroundColor: 'rgba(1, 46, 77, 0.5)',
                borderColor: 'rgb(1, 46, 77, 0.8)',
                data: data
            }]
        },

        // Configuration options go here
        options: {
            Responsive: true,
            elements: {
                point: {
                    radius: 0
                }
            }
        }
    });
}



drawChart("line-chart");

