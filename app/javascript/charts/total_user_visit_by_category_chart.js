import DonutChart from './donut_chart'
import { extractDonutDataset } from '../utils'

class TotalUserChart extends DonutChart {
  chartId = "chart_total_user_visit";
  dataset = () => extractDonutDataset(gon.totalUserVisitByCategory);
}

export const userVisit = new TotalUserChart();
