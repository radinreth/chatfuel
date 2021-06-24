export const extractLineDataset = (ds) => {
  if (ds.length == 0) return {};

  let labels = _.map(ds, (di) => _.keys(di.data));
  let flattenLabels = _.uniq(_.flatten(labels));
  return {
    labels: flattenLabels,
    datasets: ds.map((line) => ({
      label: line.name,
      backgroundColor: line.color,
      borderColor: line.color,
      data: flattenLabels.map((label) => line.data && line.data[label]),
      fill: false,
      spanGaps: true,
    })),
  };
};
