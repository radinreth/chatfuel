import * as defaults from '../data/defaults'

export const MostRequestChart = (ctx) => {
  let type = 'bar', 
      plugins = [chartDataLabels];

  let { label, colors, max, dataset } = gon.mostRequest;
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

  let options = {
    ...defaults.initOptions,
    scales: {
      ...defaults.initOptions.scales,
      yAxes: [{
        display: true,
        ticks: {
          // extra margin needed to avoid clip label on bar chart
          suggestedMax: (max + 200),
        }
      }]
    }
  };

  return new Chart(ctx, { type, plugins, data, options });
}