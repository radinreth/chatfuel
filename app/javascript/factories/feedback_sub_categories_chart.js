import * as defaults from '../data/defaults'

export const feedbackSubCategories = (ctx) => {
  let type = 'bar', 
      plugins = [chartDataLabels];

  let id = $(ctx).data("id");
  let { ratingLabels, dataset } = gon.feedbackSubCategories[id];

  let data = {
    labels: ratingLabels,
    datasets: _.map(dataset, (el) => el)
  };

  let { scales } = defaults.initOptions
  let flatten = _.flatten(_.map(dataset, e => e.data))
  let max = _.max(flatten)
  let top = Math.round( max * 0.2 )

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
          max: max + top
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

  return new Chart(ctx, { type, plugins, data, options });
}
