import * as defaults from '../data/defaults'

export const MostRequestChart = (ctx) => {
  let type = 'bar', 
      plugins = [chartDataLabels];

  let { colors, dataset } = gon.mostRequest;
  let [dataLabels, values] = [_.keys(dataset), _.values(dataset)];
  let titles = _.map(values, el => el.value);
  let counts = _.map(values, el => el.count);

  let data = {
    labels: dataLabels,
    datasets: [
      {
        ...defaults.initData.datasets[0],
        label: gon.most_requested_label,
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

  return new Chart(ctx, { type, plugins, data, options });
}
