import DonutChart from './donut_chart'
import { extractDonutDataset } from '../utils/donut_chart'

class FeedbackByGender extends DonutChart {
  chartId = 'total_users_feedback_by_gender';
  dataset = () => extractDonutDataset(gon.totalUserFeedbackByGender);
}

export const feedbackByGender = new FeedbackByGender();
