// OWSO Information Accessed
import { mostRequestServiceAccess } from './owso-information-accessed/most_request_service_access_chart';
import { informationAccess } from './owso-information-accessed/access_info_chart';
import { mainServiceAccess } from './owso-information-accessed/access_main_service_chart';
import { mostPopularAccess } from './owso-information-accessed/most_tracked_periodic_chart';
import { ticketTrackingAccess } from './owso-information-accessed/ticket_tracking_by_genders_chart';

// Citizen Feedback
import { genderFeedback } from './citizen-feedback/gender_feedback_chart';
import { overallFeedback } from './citizen-feedback/overall_rating_chart';
import { trendingFeedback } from './citizen-feedback/feedback_trend_chart';


import { feedbackSubCategories } from './feedback_sub_categories_chart';

// ow4c charts
import { userVisit } from './total_user_visit_by_category_chart';
import { userGender } from './total_user_by_gender_chart';
import { userFeedback } from './total_user_feedback_chart';

export const renderChart = function () {
  OWSO.Util.chartReg();

  // $.each( charts, function(_, f) { f() });

  // let ctx = 'chart_feedback_by_sub_category';
  // feedbackSubCategories(ctx, gon.feedbackSubCategories);

  // public dashboard
  // -- OWSO Information Accessed
  // mostRequestServiceAccess.render();
  // informationAccess.render();
  // mainServiceAccess.render();
  // mostPopularAccess.render();
  // ticketTrackingAccess.render();

  // -- citizen feedback
  // genderFeedback.render();
  // overallFeedback.render();
  // trendingFeedback.render();

  // tech tool dashboard
  // userVisit.render();
  // userGender.render();
  // userFeedback.render();
}

// const charts = [  feedbackTrend];
