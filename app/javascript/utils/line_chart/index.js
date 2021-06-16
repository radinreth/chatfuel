export const extractLineDataset = (ds) => {
  if (ds.length == 0) return {};

  let labels = _.keys(ds[0].data);
  return {
    labels: labels,
    datasets: ds.map((line) => ({
      label: line.name,
      backgroundColor: line.color,
      borderColor: line.color,
      data: labels.map((label) => line.data[label]),
      fill: false,
      spanGaps: true,
    })),
  };
};
