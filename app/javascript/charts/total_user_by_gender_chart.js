import { sum } from '../utils/array'
import { generateLabels } from '../data/piechart/defaults'

export const totalUserByGender = () => {
  let type = 'doughnut', 
      plugins = [chartDataLabels];

  let { colors, dataset } = gon.totalUserByGender;
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
      labels: {
        boxWidth: 8,
        usePointStyle: true,
        generateLabels: generateLabels
      }
    },
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

  new Chart('total_user_gender', { type, plugins, data, options });
}
