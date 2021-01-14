import * as defaults from '../../data/defaults'

const setScale = ({ suggestedMax }) => {
  let { scales } = defaults.initOptions

  return {
    ...scales,
    yAxes: [{
      ...scales.yAxes[0],
      ticks: {
        beginAtZero: true,
        suggestedMax: suggestedMax
      }
    }],
    xAxes: [{
      ...scales.xAxes[0],
      maxBarThickness: 50,
      ticks: {
        maxRotation: 0,
        minRotation: 0,
      }
    }]
  }
}

const getMax = (array, { padding }) => Math.round( _.max(array) * padding )

const setOptions = (ds) => {
  let data = _.flatten(_.map(ds, e => e.data))

  return {
    ...defaults.initOptions,
    legend: {
      display: true,
      labels: {
        boxWidth: 12
      }
    },
    scales: setScale({ suggestedMax: getMax(data, { padding: 1.25 }) })
  }
}

export { setOptions }
