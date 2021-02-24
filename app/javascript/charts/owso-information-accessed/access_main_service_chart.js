import ScatterChart from '../scatter_chart'
import { suggestedMax } from '../../utils/bar_chart'
import { extractScatterDataset } from '../../utils/line_chart/scatter_chart'

class MainServiceAccessChart extends ScatterChart {
  chartId = "chart_number_access_by_main_services";
  
  suggestedMax = (data) => suggestedMax(data, 1.2);
  dataset = () => extractScatterDataset(gon.accessMainService);
}

export const mainServiceAccess = new MainServiceAccessChart();
