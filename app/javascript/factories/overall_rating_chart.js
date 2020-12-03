import * as defaults from '../data/defaults'

export const overallRating = (ctx) => {
  let type = 'bar', 
      plugins = [chartDataLabels];

  let { ratingLabels, dataset } = gon.overallRating;

  let data = {
    labels: ratingLabels,
    datasets: _.map(dataset, (el) => el)
  };

  let { scales } = defaults.initOptions
  let flatten = _.flatten(_.map(dataset, e => e.data))
  let max = _.max(flatten)
  let suggestedMax = Math.round( max * 1.2 )

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
          suggestedMax: suggestedMax
        }
      }]
    }
  };

  return new Chart(ctx, { type, plugins, data, options });
}
