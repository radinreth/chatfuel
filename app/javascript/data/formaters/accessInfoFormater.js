import * as defaults from '../defaults'

export const accessInfo = ({ colors, dataset }) => {
  let [labels, values] = [_.keys(dataset), _.values(dataset)];

  return {
    labels: labels,
    datasets: [
      {
        ...defaults.initData.datasets[0],
        backgroundColor: colors,
        data: values,
      }
    ]
  };
}
