import { setOptions } from "./feedback_sub_categories/utils"

export const feedbackSubCategories = (ctx, rs) => {
  let type = 'bar', plugins = [chartDataLabels];
  let { ratingLabels, dataset } = rs;
  let options = setOptions(dataset);

  let data = {
    labels: ratingLabels,
    datasets: _.map(dataset, (el) => el)
  };

  return new Chart(ctx, { type, plugins, data, options });
}
