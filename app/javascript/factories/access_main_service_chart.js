import * as defaults from '../data/defaults'

export const accessMainService = (ctx) => {
  let type = 'line', 
      plugins = [chartDataLabels];

  let { colors, dataset } = gon.accessMainService;
  let [serviceNames, values] = [_.keys(dataset), _.values(dataset)];

  let data = {
    labels: serviceNames,
    datasets: [
      {
        ...defaults.initData.datasets[0],
        backgroundColor: colors,
        data: values,
        fill: false,
        pointRadius: 5,
        pointHoverRadius: 10,
        showLine: false
      }
    ]
  };

  let { scales } = defaults.initOptions
  let max = _.max(values)
  let suggestedMax = Math.round( max * 1.25 )

  let options = {
    ...defaults.initOptions,
    layout: {
      padding: {
        right: 50
      }
    },
    plugins: {
      datalabels: {
        anchor: "end",
        align: "end",
        rotation: 0,
        textAlign: "center",
        backgroundColor: "#2F3559",
        color: "#FFF",
        font: {
          size: 10
        }
      }
    },
    elements: {
      point: {
        pointStyle: "circle"
      }
    },
    scales: {
      ...scales,
      yAxes: [{
        display: true,
        ticks: {
          beginAtZero: true,
          suggestedMax: suggestedMax
        }
      }],
    }
  }

  return new Chart(ctx, { type, plugins, data, options });
}
