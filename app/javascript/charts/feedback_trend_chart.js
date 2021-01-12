import * as defaults from '../data/defaults'

export const feedbackTrend = () => {
  let type = 'bar', 
      plugins = [chartDataLabels];

  let { ratingLabels, dataset } = gon.feedbackTrend;

  let data = {
    labels: ratingLabels,
    datasets: _.map(dataset, (el) => el)
  };

  let { scales } = defaults.initOptions
  let flatten = _.flatten(_.map(dataset, e => e.data))
  let max = _.max(flatten)
  let suggestedMax = Math.round( max * 1.20 )

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
      display: true,
      labels: {
        boxWidth: 12
      }
    },
    scales: {
      ...scales,
      yAxes: [{
        ...scales.yAxes[0],
        ticks: {
          suggestedMax: suggestedMax
        }
      }],
      xAxes: [{
        ...scales.xAxes[0],
        ticks: {
          maxRotation: 0,
          minRotation: 0,
        }
      }]
    }
  };

  new Chart('chart_owso_feedback_trend', { type, plugins, data, options });
}
