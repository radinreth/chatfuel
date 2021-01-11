import { sum } from '../utils/array'
import { labels } from '../data/piechart/defaults'

export const totalUserFeedback = () => {
  let type = 'doughnut', 
      plugins = [chartDataLabels];

  let { colors, dataset } = gon.totalUserFeedback;
  let [feedbackLabels, values] = [_.keys(dataset), _.values(dataset)];

  let data = {
    labels: feedbackLabels,
    total: sum(values),
    datasets: [
      {
        backgroundColor: colors,
        data: values,
      }
    ]
  };

  let options = {
    legend: {
      position: "left",
      labels: labels
    },
    cutoutPercentage: 80,
    plugins: {
      datalabels: {
        backgroundColor: function(context) {
          return context.dataset.backgroundColor;
        },
        borderColor: 'white',
        borderRadius: 100,
        padding: 10,
        borderWidth: 2,
        color: 'white',
        display: false,
        font: {
          family: "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif",
          weight: 'bold'
        },
        formatter: Math.round
      }
    }
  };

  $.each($('.total_user_feedback'), function(i, ele) {
    let canvasId = $(ele).attr("id");
    new Chart(canvasId, { type, plugins, data, options });
  });
}
