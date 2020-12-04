import * as defaults from '../data/defaults'

export const accessInfo = () => {
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
  let max = _.max(values)
  let suggestedMax = Math.round( max * 1.2 )

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
      yAxes: [{
        ...scales.yAxes[0],
        ticks: {
          suggestedMax: suggestedMax
        }
      }],
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

  new Chart('chart_information_access_by_period', { type, plugins, data, options });
}
