import { userVisit } from '../total_user_visit_by_category_chart'
import { userFeedback } from '../total_user_feedback_chart'

export const summaryPublic = {
  render: function() {
    userVisit.render({watermark: false});
    userFeedback.render({watermark: false})
  }
}