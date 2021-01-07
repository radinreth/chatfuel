export const feedbackTrend = ({ ratingLabels, dataset }) => {
  return {
    labels: ratingLabels,
    datasets: _.map(dataset, (el) => el)
  };
}
