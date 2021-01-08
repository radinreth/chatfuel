import * as defaults from '../data/defaults'

export const extractData = (raw) => {
  let { colors, dataset } = raw;
  let [monthLabels, values] = [_.keys(dataset), _.values(dataset)];

  return {
    labels: monthLabels,
    datasets: [
      {
        ...defaults.initData.datasets[0],
        backgroundColor: colors,
        data: values,
      }
    ]
  };
}

export const ticketTracking = () => {
  let type = 'bar', 
      plugins = [chartDataLabels];

  let data = extractData(gon.ticketTracking);
  let { scales } = defaults.initOptions
  let max = _.max(data.datasets[0].data)
  let suggestedMax = Math.round( max * 1.2 )

  let options = {
    ...defaults.initOptions,
    plugins: {
      datalabels: {
        anchor: "end",
        align: "end",
        rotation: 0,
        textAlign: "center",
        font: {
          family: "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif",
        }
      }
    },
    scales: {
      ...scales,
      yAxes: [{
        ...scales.yAxes[0],
        ticks: {
          beginAtZero: true,
          suggestedMax: suggestedMax
        }
      }],
      xAxes: [{
        ...scales.xAxes,
        ticks: {
          ...scales.xAxes.ticks,
          maxRotation: 0,
          minRotation: 0,
        }
      }]
    }
  }

  new Chart('number_of_ticket_tracking', { type, plugins, data, options });
}
