import GroupBarChart from '../group_bar_chart'

class TrendingFeedbackChart extends GroupBarChart {
  chartId = 'chart_owso_feedback_trend';

  format = () => {
    let { labels, dataset } = gon.feedbackTrend;
    return { labels, datasets: _.map(dataset, (el) => el) };
  }
}

export const trendingFeedback = new TrendingFeedbackChart();
