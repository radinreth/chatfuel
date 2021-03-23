import * as defaults from '../data/defaults'

export const overallRating = () => {
  let type = 'bar', 
      plugins = [chartDataLabels];

  let { labels, dataset } = gon.overallRating;

  let data = {
    labels: labels,
    datasets: _.map(dataset, (el) => el)
  };

  let { scales } = defaults.initOptions
  let flatten = _.flatten(_.map(dataset, e => e.data))
  let max = _.max(flatten)
  let suggestedMax = Math.round( max * 1.2 )

  let options = {
    ...defaults.initOptions,
    legend: {
      display: true,
      labels: { boxWidth: 12 }
    },
    scales: {
      ...scales,
      xAxes: [{
        maxBarThickness: 50,
      }],
      yAxes: [{
        ...scales.yAxes[0],
        ticks: {
          suggestedMax: suggestedMax
        }
      }]
    }
  };

  new Chart('chart_overall_rating_by_owso', { type, plugins, data, options });
}
