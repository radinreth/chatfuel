// Citizen Feedback
import { genderFeedback } from './gender_feedback_chart';
import { overallFeedback } from './overall_rating_chart';
import { trendingFeedback } from './feedback_trend_chart';
import { subCategoriesFeedback } from './feedback_sub_categories_chart';

export const feedback = {
  instances: [
    genderFeedback,
    overallFeedback,
    trendingFeedback,
    subCategoriesFeedback
  ],
  renderCharts: function() {
    _.each(this.instances, instance => instance.render());
  }
}
