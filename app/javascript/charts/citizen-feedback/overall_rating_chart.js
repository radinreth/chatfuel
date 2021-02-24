import GroupBarChart from '../group_bar_chart'

class OverallFeedbackChart extends GroupBarChart {
  chartId = 'chart_overall_rating_by_owso';

  format = () => {
    let { labels, dataset } = gon.overallRating;
    return { labels, datasets: _.map(dataset, (el) => el) };
  }
}

export const overallFeedback = new OverallFeedbackChart();
