import { extract } from '../index'

export const extractBarDataset = (ds) => {
  let { labels, colors, values } = extract(ds);

  return {
    labels: labels,
    datasets: [
      {
        minBarLength: 2,
        backgroundColor: colors,
        data: values,
        maxBarThickness: 50
      }
    ]
  };
}

export const suggestedMax = function ( array, scale = 1.2 ) {
  return _.max(array) * scale
}
