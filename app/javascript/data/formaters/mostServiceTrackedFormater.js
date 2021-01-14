import * as defaults from '../defaults'

export const mostServiceTracked = ({ colors, dataset }) => {
  let [labels, values] = [_.keys(dataset), _.values(dataset)];
  let titles = _.map(values, el => el.value);
  let counts = _.map(values, el => el.count);

  return {
    labels: labels,
    datasets: [
      {
        ...defaults.initData.datasets[0],
        label: gon.most_tracked_label,
        backgroundColor: colors,
        dataTitles: titles,
        data: counts,
      }
    ]
  };
}
