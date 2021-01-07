import * as defaults from '../data/defaults'

export const extractData = ({ ratingLabels, dataset }) => {
  return {
    labels: ratingLabels,
    datasets: _.map(dataset, (el) => el)
  };
}

export const feedbackTrend = () => {
  let type = 'bar', 
      plugins = [chartDataLabels];

  let data = extractData(gon.feedbackTrend);

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

  return new Chart(ctx, { type, plugins, data, options });
}
