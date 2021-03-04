import GroupBarChart from '../group_bar_chart'

class SubCategoriesFeedbackChart extends GroupBarChart {
  chartId = 'chart_feedback_by_sub_category';

  format = () => {
    let { labels, dataset } = this.ds;
    return { labels, datasets: _.map(dataset, (el) => el) };
  }
}

export const subCategoriesFeedback = new SubCategoriesFeedbackChart();
