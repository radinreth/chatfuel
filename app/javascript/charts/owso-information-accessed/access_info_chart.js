import BarChart from '../bar_chart'
import { extractBarDataset, ticksOptions, suggestedMax } from '../../utils/bar_chart'

class InformationAccessChart extends BarChart {
  chartId = 'chart_information_access_by_period';
  ticksOptions = ticksOptions;

  suggestedMax = (data) => suggestedMax(data, 1.5);
  dataset = () => extractBarDataset(gon.accessInfo);
}

export const informationAccess = new InformationAccessChart();
