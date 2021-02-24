import { extract } from '../../index'

export const extractScatterDataset = (ds) => {
  let { labels, colors, values } = extract(ds);

  return {
    labels: labels,
    datasets: [{
      fill: false,
      pointRadius: 5,
      pointHoverRadius: 10,
      showLine: false,
      backgroundColor: colors,
      data: values
    }]
  }
}