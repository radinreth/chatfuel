import FilteredBarChart from "../filtered_bar_chart";
import { suggestedMax } from "../../utils/bar_chart";

class MostPopularAccessChart extends FilteredBarChart {
  chartId = "chart_most_service_tracked_periodically";

  suggestedMax = (data) => suggestedMax(data, 1.5);
  dataset = () => this.format(gon.mostTrackedPeriodic);
}

export const mostPopularAccess = new MostPopularAccessChart();
