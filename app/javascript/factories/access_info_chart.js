import * as defaults from '../data/defaults'

export const AccessInfoChart = (ctx) => {
  let type = 'bar', 
      plugins = [chartDataLabels];

  let { colors, dataset } = gon.accessInfo;
  let [monthLabels, values] = [_.keys(dataset), _.values(dataset)];

  let data = {
    labels: monthLabels,
    datasets: [
      {
        ...defaults.initData.datasets[0],
        backgroundColor: colors,
        data: values,
      }
    ]
  };

  let { scales } = defaults.initOptions

  let options = {
    ...defaults.initOptions,
    plugins: {
      datalabels: {
        anchor: "end",
        align: "end",
        rotation: 0,
        textAlign: "center",
      }
    },
    scales: {
      ...scales,
      xAxes: [{
        ...scales.xAxes,
        ticks: {
          ...scales.xAxes.ticks,
          maxRotation: 0,
          minRotation: 0,
        }
      }]
    }
  }

  return new Chart(ctx, { type, plugins, data, options });
}
