export const feedbackTrend = ({ labels, dataset }) => {
  return {
    labels: labels,
    datasets: _.map(dataset, (el) => el)
  };
}