
// return max of array
function get_maximum(arr) {
   return arr.reduce((a, b) => { return Math.max(a, b) });
}

function drawLineChart(divId, data, chartType) {
    let labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];         // y-axis data

    let chart_ele = document.getElementById(divId).getContext('2d');

    var chart = new Chart(chart_ele, {
        // The type of chart we want to create
        type: chartType,

        // The data for our dataset
        data: {
            labels: labels,
            datasets: [{
                label: 'Profile Views',
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
            },
            scales: {
                yAxes: [{
                    display: true,
                    ticks: {
                        beginAtZero: true,   // minimum value will be 0.
                        suggestedMax: get_maximum(data) + 1
                    }
                }]
            }
        }
    });
}


function drawBarChart(id, data, chartType) {
    let labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    // Vertical bar chart
    var ctx = document.getElementById(id);
    ctx.height = 150;

    var myChart = new Chart(ctx, {
        type: chartType,
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
}




// get index of day
function get_day_index(day) {
    if (day == "Monday") return 0;
    if (day == "Tueday") return 1;
    if (day == "Wednesday") return 2;
    if (day == "Thursday") return 3;
    if (day == "Friday") return 4;
    if (day == "Saturday") return 5;
    if (day == "Sunday") return 6;
}


// to get user week days summary detail
function get_user_week_days_summary() {

    $.ajax({
        'async': false,
        type: "POST",
        url: "sdashboard.aspx/Get_User_Week_Days_Summary",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var userWeekDaysViewsCounts = xml.find("Table1");           

            // to display user views week days summary detail
            let data = [0, 0, 0, 0, 0, 0, 0];
            for (var i = 0; i < userWeekDaysViewsCounts.length; ++i) {
                let dayName = userWeekDaysViewsCounts[i].getElementsByTagName("WeekDayName")[0].childNodes[0].nodeValue;
                data[get_day_index(dayName)] = userWeekDaysViewsCounts[i].getElementsByTagName("UserTotalViews")[0].childNodes[0].nodeValue;
            }
            // draw line chart
            drawLineChart("line-chart", data, "line");

            var userWeekDaysOrdersCounts = xml.find("Table2");           
            // to display user orders week days summary detail
            data = [0, 0, 0, 0, 0, 0, 0];
            for (var i = 0; i < userWeekDaysOrdersCounts.length; ++i) {
                let dayName = userWeekDaysOrdersCounts[i].getElementsByTagName("WeekDayName")[0].childNodes[0].nodeValue;
                data[get_day_index(dayName)] = userWeekDaysOrdersCounts[i].getElementsByTagName("UserTotalOrders")[0].childNodes[0].nodeValue;
            }
            // draw chart
            drawBarChart("bar-chart", data, "bar");
        },
        failure: function (response) {
            alert("Load Get User Views Week Days Summary Failed");
        }
    });
};


window.onload = get_user_week_days_summary();