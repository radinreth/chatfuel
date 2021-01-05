import * as defaults from '../data/defaults'

export const extractData = (raw) => {
  // let { colors, dataset } = raw;
  // let [monthLabels, values] = [_.keys(dataset), _.values(dataset)];
  
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
  
  // return {
  //   labels: monthLabels,
  //   datasets: [
  //     {
  //       ...defaults.initData.datasets[0],
  //       backgroundColor: colors,
  //       data: values,
  //     }
  //   ]
  // };
}

export const overview = () => {
  let type = 'line', 
      plugins = [chartDataLabels];

  let data = extractData(gon.overview);
  // let { scales } = defaults.initOptions
  // let max = _.max(data.datasets[0].data)
  // let suggestedMax = Math.round( max * 1.2 )

  let options = {
    plugins: {
      datalabels: {
        ...defaults.initOptions.plugins.datalabels,
        display: false
      },
    },
    // responsive: true,
    // tooltips: {
    //   mode: 'index',
    //   intersect: false,
    // },
    // hover: {
    //   mode: 'nearest',
    //   intersect: true
    // },
    scales: {
      xAxes: [{
        ticks:{
          display: true,
          autoSkip: true,
          maxTicksLimit: 3,
        }
      }]
    }
  }

  new Chart('overview', { type, plugins, data, options });
}
