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
