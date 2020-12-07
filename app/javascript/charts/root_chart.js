import { mostRequest } from './most_request_chart';
import { genderInfo } from './information_access_by_gender_chart';
import { accessInfo } from './access_info_chart';
import { accessMainService } from './access_main_service_chart';
import { mostTrackedPeriodic } from './most_tracked_periodic_chart';
import { ticketTrackingByGenders } from './ticket_tracking_by_genders_chart';
import { overallRating } from './overall_rating_chart';
import { feedbackTrend } from './feedback_trend_chart';
import { feedbackSubCategories } from './feedback_sub_categories_chart';

export const renderChart = function () {
  $.each( charts, function(_, f) { f() });
  $(".chart_feedback_by_sub_category").each(function(_, dom) {
    feedbackSubCategories(dom);
  });
}

const charts = [  mostRequest, 
                  genderInfo, 
                  accessInfo,
                  accessMainService,
                  mostTrackedPeriodic,
                  ticketTrackingByGenders,
                  overallRating,
                  feedbackTrend ];
