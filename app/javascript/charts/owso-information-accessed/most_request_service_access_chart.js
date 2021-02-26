import FilteredBarChart from '../filtered_bar_chart'
import { suggestedMax } from '../../utils/bar_chart'

class MostRequestServiceAccessChart extends FilteredBarChart {
  chartId = 'chart_most_requested_services';

  suggestedMax = (data) => suggestedMax(data, 1.5);
  dataset = () => this.format(gon.mostRequest);
}

export const mostRequestServiceAccess = new MostRequestServiceAccessChart();
