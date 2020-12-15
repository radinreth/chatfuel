import * as defaults from '../data/defaults'

export const mostTrackedPeriodic = ( collection = null) => {
  let type = 'bar', 
      plugins = [chartDataLabels];

  let { label, colors, dataset } = collection || gon.mostTrackedPeriodic;
  let [dataLabels, values] = [_.keys(dataset), _.values(dataset)];
  let titles = _.map(values, el => el.value);
  let counts = _.map(values, el => el.count);

  let data = {
    labels: dataLabels,
    datasets: [
      {
        ...defaults.initData.datasets[0],
        label: label,
        backgroundColor: colors,
        dataTitles: titles,
        data: counts,
      }
    ]
  };

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

  new Chart('chart_most_service_tracked_periodically', { type, plugins, data, options });
}
