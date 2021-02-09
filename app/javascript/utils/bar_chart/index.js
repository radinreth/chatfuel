import { extract } from '../index'

export const extractBarDataset = (ds) => {
  let { labels, colors, values } = extract(ds);

  return {
    labels: labels,
    datasets: [
      {
        maxBarThickness: 36,
        minBarLength: 2,
        backgroundColor: colors,
        data: values,
      }
    ]
  };
}

export const suggestedMax = function ( array ) {
  return Math.round( _.max(array) * 1.2 )
}
