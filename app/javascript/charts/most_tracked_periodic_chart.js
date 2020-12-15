import * as defaults from '../data/defaults'

export const extractData = (raw) => {
  let { label, colors, dataset } = raw;
  let [dataLabels, values] = [_.keys(dataset), _.values(dataset)];
  let titles = _.map(values, el => el.value);
  let counts = _.map(values, el => el.count);

  return {
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
}

export const mostTrackedPeriodic = ( collection = null) => {
  let type = 'bar', 
      plugins = [chartDataLabels];

  let data = extractData(collection || gon.mostTrackedPeriodic);
  let { scales } = defaults.initOptions
  let max = _.max(data.datasets.data)
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
