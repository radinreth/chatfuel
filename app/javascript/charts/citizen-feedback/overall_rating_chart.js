import BarChart from '../bar_chart'
import { suggestedMax } from '../../utils/bar_chart'

class OverallFeedbackChart extends BarChart {
  childOptions =  { legend: {
                    display: true,
                    labels: { boxWidth: 12 }}}
  chartId = 'chart_overall_rating_by_owso';

  suggestedMax = (data) => suggestedMax(data, 1.2);
  dataset = () => this.format();
  format = () => {
    let { labels, dataset } = gon.overallRating;
    return { labels, datasets: _.map(dataset, (el) => el) };
  }
}

export const overallFeedback = new OverallFeedbackChart();
