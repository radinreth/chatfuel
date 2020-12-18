import { sum } from '../utils/array'
import { generateLabels, isDisplay } from '../data/piechart/defaults'

export const genderInfo = () => {
  let type = 'pie', 
      plugins = [chartDataLabels];

  let { colors, dataset } = gon.genderInfo;
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
        borderRadius: 100,
        padding: 10,
        borderWidth: 2,
        color: 'white',
        display: isDisplay,
        font: {
          family: "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif",
          weight: 'bold'
        },
        formatter: Math.round
      }
    }
  };

  new Chart('chart_information_access_by_gender', { type, plugins, data, options });
}
