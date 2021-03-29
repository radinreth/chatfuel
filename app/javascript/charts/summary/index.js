import { userGender } from '../total_user_by_gender_chart'
import { ticketTracking } from '../ticket_tracking_chart'
import { overview } from '../overview_chart'
import { summaryPublic } from '../summary-public'
import { infoAccess } from '../owso-information-accessed'
import { citizenFeedback } from '../citizen-feedback'
import { root_path } from 'routes';

export const summary = {
  render: function() {
    summaryPublic.render();
    userGender.render({watermark: false});
    ticketTracking.render({watermark: false});
    overview.render({watermark: false});
  }
}

export const init = () => {
  fetchRemote("summary_data", (response) => {
    window.gon = response
    summaryPublic.render();
    loadInformationAccessCharts();
  } );
}

const fetchRemote = (fetch, func) => {
  $.get(root_path(), { options: gon.query_options, fetch }, func, "json");
}

const loadInformationAccessCharts = () => {
  fetchRemote("access_info_data", (response) => {
    window.gon = response
    infoAccess.render();
    userGender.render();
    loadFeedbackCharts();
    OWSO.DashboardShow.loadProvinceMostRequest();
  });
}

const loadFeedbackCharts = () => {
  fetchRemote("citizen_feedback_data", (response) => {
    window.gon = response
    citizenFeedback.render();
    OWSO.DashboardShow.runAsPublicFeedback();
  });
}
