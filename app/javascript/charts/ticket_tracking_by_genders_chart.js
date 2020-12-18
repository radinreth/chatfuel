import { sum } from '../utils/array'
import { generateLabels } from '../data/piechart/defaults'

export const ticketTrackingByGenders = () => {
  let type = 'pie', 
      plugins = [chartDataLabels];

  let { colors, dataset } = gon.ticketTrackingByGenders;
  let [genderLabels, values] = [_.keys(dataset), _.values(dataset)];

  let data = {
    labels: genderLabels,
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
        boxWidth: 12,
        generateLabels: generateLabels
      }
    },
    plugins: {
      datalabels: {
        backgroundColor: function(context) {
          return context.dataset.backgroundColor;
        },
        borderColor: 'white',
        borderRadius: 25,
        borderWidth: 2,
        borderRadius: 100,
        padding: 10,
        color: 'white',
        display: true,
        font: {
          family: "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif",
          weight: 'bold'
        },
        formatter: Math.round
      }
    }
  };

  new Chart('chart_ticket_tracking_by_gender', { type, plugins, data, options });
}
