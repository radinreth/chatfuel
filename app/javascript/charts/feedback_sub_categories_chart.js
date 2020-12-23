import { setOptions } from "./feedback_sub_categories/utils"

export const feedbackSubCategories = (ctx, rs) => {
  let type = 'bar', plugins = [chartDataLabels];
  let { locationName, ratingLabels, dataset } = rs;
  let options = setOptions(dataset);

  let data = {
    labels: ratingLabels,
    datasets: _.map(dataset, (el) => el)
  };

  $(ctx).closest(".card-body").prev(".card-header").find(".chart-head").text(locationName);
  return new Chart(ctx, { type, plugins, data, options });
}
