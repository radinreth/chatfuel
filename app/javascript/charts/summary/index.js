import { userGender } from '../total_user_by_gender_chart'
import { ticketTracking } from '../ticket_tracking_chart'
import { overview } from '../overview_chart'
import { summaryPublic } from '../summary-public'

export const summary = {
  render: function() {
    summaryPublic.render();
    userGender.render({watermark: false});
    ticketTracking.render({watermark: false});
    overview.render({watermark: false});
  }
}