import * as defaults from '../data/defaults'

export const feedbackSubCategories = () => {
  let type = 'bar', 
      plugins = [chartDataLabels];

  let { ratingLabels, dataset } = gon.feedbackSubCategories;

  let data = {
    labels: ratingLabels,
    datasets: _.map(dataset, (el) => el)
  };

  let { scales } = defaults.initOptions
  let flatten = _.flatten(_.map(dataset, e => e.data))
  let max = _.max(flatten)
  let suggestedMax = Math.round( max * 1.25 )

  let options = {
    ...defaults.initOptions,
    legend: {
      display: true
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
        ...scales.xAxes[0],
        ticks: {
          maxRotation: 0,
          minRotation: 0,
        }
      }]
    }
  };

  return new Chart('chart_feedback_by_sub_category', { type, plugins, data, options });
}
