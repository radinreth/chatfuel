import * as defaults from '../defaults'

export const mostServiceTracked = ({ label, colors, dataset }) => {
  let [dataLabels, values] = [_.keys(dataset), _.values(dataset)];
  let titles = _.map(values, el => el.value);
  let counts = _.map(values, el => el.count);

  return {
    labels: dataLabels,
    datasets: [
      {
        ...defaults.initData.datasets[0],
        label: label,
        backgroundColor: colors,
        dataTitles: titles,
        data: counts,
      }
    ]
  };
}
