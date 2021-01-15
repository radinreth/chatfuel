import { mostRequest } from './most_request_chart';
import { genderInfo } from './information_access_by_gender_chart';
import { accessInfo } from './access_info_chart';
import { accessMainService } from './access_main_service_chart';
import { mostTrackedPeriodic } from './most_tracked_periodic_chart';
import { ticketTrackingByGenders } from './ticket_tracking_by_genders_chart';
import { overallRating } from './overall_rating_chart';
import { feedbackTrend } from './feedback_trend_chart';
import { feedbackSubCategories } from './feedback_sub_categories_chart';
import { userVisit } from './total_user_visit_by_category_chart';
import { totalUserFeedback } from './total_user_feedback_chart';
import { totalUserByGender } from './total_user_by_gender_chart';

export const renderChart = function () {
  OWSO.Util.chartReg();

  $.each( charts, function(_, f) { f() });

  let ctx = 'chart_feedback_by_sub_category';
  feedbackSubCategories(ctx, gon.feedbackSubCategories);

  userVisit.render();
}

const charts = [  mostRequest, 
                  genderInfo, 
                  accessInfo,
                  accessMainService,
                  mostTrackedPeriodic,
                  ticketTrackingByGenders,
                  overallRating,
                  feedbackTrend,
                  totalUserFeedback,
                  totalUserByGender ];
