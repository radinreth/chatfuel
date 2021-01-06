import * as defaults from '../data/defaults'

export const extractData = (raw) => {
  return {
    labels: _.keys(raw[0].data),
    datasets: raw.map(function(ds) {
      return {
        label: ds.name,
        backgroundColor: ds.color,
        borderColor: ds.color,
        data: _.values(ds.data),
        fill: false,
      }
    })
  };
}

export const overview = () => {
  let type = 'line', 
      plugins = [chartDataLabels];

  let data = extractData(gon.overview);

  let options = {
    legend: {
      display: true
    },
    plugins: {
      datalabels: {
        ...defaults.initOptions.plugins.datalabels,
        display: false,
      },
    },
    scales: {
      xAxes: [{
        ticks:{
          display: true,
          autoSkip: true,
          maxRotation: 0,
          minRotation: 0,
          maxTicksLimit: 6,
        }
      }]
    }
  }

  new Chart('chart-overview', { type, plugins, data, options });
}
