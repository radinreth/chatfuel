document.addEventListener('turbolinks:load', function() {
  var ctx = document.getElementById('myChart').getContext('2d');
  var myChart = new Chart(ctx, {
    type: 'line',
    data: {
      labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
      datasets: [
        {
          label: 'Accessed',
          data: [12, 19, 3, 5, 2, 1, 3],
          backgroundColor: 'red',
          borderColor: 'red',
          fill: false,
        },
        {
          label: 'Applied',
          data: [22, 5, 2, 6, 9, 10, 13],
          backgroundColor: 'blue',
          borderColor: 'blue',
          fill: false,
        },
        {
          label: 'Completed',
          data: [5, 7, 1, 9, 19, 4, 8],
          backgroundColor: 'orange',
          borderColor: 'orange',
          fill: false,
        }
      ]
    },
    options: {
      responsive: true,
      title: {
        display: true,
        text: 'OWSO services'
      }
    }
  })
})
