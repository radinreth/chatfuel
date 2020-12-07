import * as defaults from '../data/defaults'

export const mostRequest = () => {
  let type = 'bar', plugins = [chartDataLabels];

  let { label, colors, dataset } = gon.mostRequest;
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

  let max = _.max(counts)
  let suggestedMax = Math.round( max * 1.4 )

  let options = {
    ...defaults.initOptions,
    scales: {
      ...defaults.initOptions.scales,
      yAxes: [{
        display: true,
        ticks: {
          suggestedMax: suggestedMax,
        }
      }]
    }
  };

  new Chart('chart_most_requested_services', { type, plugins, data, options });
}
