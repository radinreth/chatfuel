import BaseChart from "./base_chart";
import { labels } from '../data/donutchart/defaults'

class DonutChart extends BaseChart {
  type = "doughnut";
  options = Object.assign({}, this.baseOptions, {
    legend: {
      position: "left",
      labels: labels
    },
    cutoutPercentage: 80
  });
}

export default DonutChart;
