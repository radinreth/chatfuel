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

export const suggestedMax = function ( array, scale = 1.2 ) {
  return _.max(array) * scale
}

export const ticksOptions = {
  maxRotation: 45,
  minRotation: 45,
  callback: function(value) {
    let maxLength = 10,
        ellipsisValue = `${value.substr(0, 10)}...`;
    return (value.length >= maxLength) ? ellipsisValue : value;
  }
}
