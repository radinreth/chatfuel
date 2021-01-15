import { sum } from '../utils/array'
import DonutChart from './donut_chart'

class TotalUserChart extends DonutChart {
  chartId = "chart_total_user_visit";

  dataset = () => {
    let { colors, dataset } = gon.totalUserVisitByCategory;
    let [labels, values] = [_.keys(dataset), _.values(dataset)];

    return {
      labels: labels,
      total: sum(values),
      datasets: [
        {
          backgroundColor: colors,
          data: values,
        }
      ]
    };
  }
}

export const userVisit = new TotalUserChart();
