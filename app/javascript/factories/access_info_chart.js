import * as defaults from '../data/defaults'
import formater from '../data/formater'

export const accessInfo = (collection = null) => {
  let type = 'bar', 
      plugins = [chartDataLabels];

  let data = formater.accessInfo(collection || gon.accessInfo);
  let { scales } = defaults.initOptions
  let max = _.max(values)
  let suggestedMax = Math.round( max * 1.2 )

  let options = {
    ...defaults.initOptions,
    plugins: {
      datalabels: {
        anchor: "end",
        align: "end",
        rotation: 0,
        textAlign: "center",
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

  return new Chart(ctx, { type, plugins, data, options });
}
