import DonutChart from '../donut_chart'
import { extractDonutDataset } from '../../utils/donut_chart'

class GenderFeedbackChart extends DonutChart {
  chartId = "gender_feedback";
  dataset = () => extractDonutDataset(gon.genderInfo);
}

export const genderFeedback = new GenderFeedbackChart();
