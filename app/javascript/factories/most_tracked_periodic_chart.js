import * as defaults from '../data/defaults'
import formater from '../data/formater'

export const mostTrackedPeriodic = ( collection = null) => {
  let type = 'bar', 
      plugins = [chartDataLabels];

  let data = formater.mostServiceTracked(collection || gon.mostTrackedPeriodic);
  let { scales } = defaults.initOptions
  let max = _.max(counts)
  let suggestedMax = Math.round( max * 1.40 )

  let options = {
    ...defaults.initOptions,
    scales: {
      ...scales,
      xAxes: [{
        ...scales.xAxes,
        ticks: {
          ...scales.xAxes.ticks,
          maxRotation: 0,
          minRotation: 0,
        }
      }],
      yAxes: [{
        display: true,
        ticks: {
          beginAtZero: true,
          suggestedMax: suggestedMax,
        }
      }]
    }
  };

  return new Chart(ctx, { type, plugins, data, options });
}
