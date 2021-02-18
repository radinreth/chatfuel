import { setOptions } from "./feedback_sub_categories/utils"

export const feedbackSubCategories = (ctx, rs) => {
  let type = 'bar', plugins = [chartDataLabels];
  let { labels, dataset } = rs;
  let options = setOptions(dataset);

  let data = {
    labels: labels,
    datasets: _.map(dataset, (el) => el)
  };

  OWSO.Util.createOrUpdate(ctx, { type, plugins, data, options });
}
