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

export const suggestedMax = function ( array ) {
  return Math.round( _.max(array) * 1.2 )
}

export const extractLineDataset = (ds) => {
  if(ds.length == 0) return {}

  return {
    labels: _.keys(ds[0].data),
    datasets: ds.map( line => ({
        label: line.name,
        backgroundColor: line.color,
        borderColor: line.color,
        data: _.values(line.data),
        fill: false,
      }
    ))
  };
}
