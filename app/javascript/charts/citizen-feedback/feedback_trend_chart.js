import GroupBarChart from '../group_bar_chart'
import { ticksOptions } from '../../utils/bar_chart'

class TrendingFeedbackChart extends GroupBarChart {
  chartId = 'chart_owso_feedback_trend';
  ticksOptions = ticksOptions

  format = () => {
    let { labels, dataset } = this.ds;
    return { labels, datasets: _.map(dataset, (el) => el) };
  }
}

export const trendingFeedback = new TrendingFeedbackChart();
