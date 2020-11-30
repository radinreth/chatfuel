import * as defaults from '../data/defaults'

export const overallRating = (ctx) => {
  let type = 'bar', 
      plugins = [chartDataLabels];

  let { ratingLabels, dataset } = gon.overallRating;

  let data = {
    labels: ratingLabels,
    datasets: _.map(dataset, (el) => el)
  };

  let options = {
    ...defaults.initOptions
  };

  // let { scales } = defaults.initOptions

  // let options = {
  //   ...defaults.initOptions,
  //   plugins: {
  //     datalabels: {
  //       anchor: "end",
  //       align: "end",
  //       rotation: 0,
  //       textAlign: "center",
  //     }
  //   },
  //   scales: {
  //     ...scales,
  //     xAxes: [{
  //       ...scales.xAxes,
  //       ticks: {
  //         ...scales.xAxes.ticks,
  //         maxRotation: 0,
  //         minRotation: 0,
  //       }
  //     }]
  //   }
  // }

  return new Chart(ctx, { type, plugins, data, options });
}
