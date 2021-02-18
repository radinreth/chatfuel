import * as defaults from '../data/defaults'
import formater from '../data/formater'

export const feedbackTrend = () => {
  let type = 'bar', 
      plugins = [chartDataLabels];

  let data = formater.feedbackTrend(gon.feedbackTrend);

  let { scales } = defaults.initOptions
  let flatten = _.flatten(_.map(gon.feedbackTrend.dataset, e => e.data))
  let max = _.max(flatten)
  let top = Math.round( max * 0.2 )

  let options = {
    ...defaults.initOptions,
    plugins: {
      datalabels: {
        ...defaults.initOptions.plugins.datalabels,
        font: {
          size: "10"
        }
      }
    },
    legend: {
      display: true
    },
    scales: {
      ...scales,
      yAxes: [{
        ...scales.yAxes[0],
        ticks: {
          max: max + top
        }
      }],
      xAxes: [{
        ...scales.xAxes[0],
        maxBarThickness: 50,
        ticks: {
          maxRotation: 0,
          minRotation: 0,
        }
      }]
    }
  };

  OWSO.Util.createOrUpdate('chart_owso_feedback_trend', { type, plugins, data, options });
}
