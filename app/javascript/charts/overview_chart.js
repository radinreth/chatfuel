import LineChart from './line_chart'
import { extractLineDataset } from '../utils'

class OverviewChart extends LineChart {
  chartId = "chart-overview";
  dataset = () => extractLineDataset(gon.overview);
}

export const overview = new OverviewChart();
