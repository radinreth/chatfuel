import BarChart from '../bar_chart'
import { extractBarDataset, suggestedMax } from '../../utils/bar_chart'

class InformationAccessChart extends BarChart {
  chartId = 'chart_information_access_by_period';

  suggestedMax = (data) => suggestedMax(data, 1.5);
  dataset = () => extractBarDataset(gon.accessInfo);
}

export const informationAccess = new InformationAccessChart();
