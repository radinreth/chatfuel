import { userVisit } from '../total_user_visit_by_category_chart'
import { userGender } from '../total_user_by_gender_chart'
import { userFeedback } from '../total_user_feedback_chart'
import { ticketTracking } from '../ticket_tracking_chart'
import { overview } from '../overview_chart'
import { feedbackByGender } from '../feedback_by_gender_chart'

export const summary = {
  render: function() {
    userVisit.render({watermark: false});
    userGender.render({watermark: false});
    userFeedback.render({watermark: false})
    ticketTracking.render({watermark: false});
    overview.render({watermark: false});
    // feedbackByGender.render({watermark: false});
  }
}