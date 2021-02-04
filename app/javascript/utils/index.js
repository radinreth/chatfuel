const extract = (ds) => {
  let { colors, dataset } = ds;
  let [labels, values] = [_.keys(dataset), _.values(dataset)];

  return { colors, labels, values }
}

export const extractDonutDataset = (ds) => {
  let { labels, colors, values } = extract(ds);

  return {
    labels: labels,
    datasets: [
      { backgroundColor: colors, data: values }
    ]
  }
}

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

export var m = function ( data ) {
  console.log(data)
  return Math.round( _.max(data) * 1.2 )
}
