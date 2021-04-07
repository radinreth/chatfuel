import GroupBarChart from '../group_bar_chart'
import { ticksOptions } from '../../utils/bar_chart'

class OverallFeedbackChart extends GroupBarChart {
  chartId = 'chart_overall_rating_by_owso';
  ticksOptions = {}

  format = () => {
    let { labels, dataset } = this.ds;
    this.ticksOptions = (labels && labels.length > 4) ? ticksOptions : {}

    return { labels, datasets: _.map(dataset, (el) => el) };
  }
}

export const overallFeedback = new OverallFeedbackChart();
