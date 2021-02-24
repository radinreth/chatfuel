import BarChart from '../bar_chart'
import { suggestedMax } from '../../utils/bar_chart'

class TrendingFeedbackChart extends BarChart {
  childOptions =  { legend: {
                    display: true,
                    labels: { boxWidth: 12 }}}
  chartId = 'chart_owso_feedback_trend';

  suggestedMax = (data) => suggestedMax(data, 1.2);
  dataset = () => this.format();
  format = () => {
    let { labels, dataset } = gon.feedbackTrend;
    return { labels, datasets: _.map(dataset, (el) => el) };
  }
}

export const trendingFeedback = new TrendingFeedbackChart();
