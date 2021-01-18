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
