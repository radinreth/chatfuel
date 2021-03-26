class Gonify
  def initialize(query)
    @query = query
  end

  def chart_data
    access_info_data.merge(citizen_feedback_data, dashboard_data)
  end

  def dashboard_data
    summary_data.merge({
      totalUserByGender: @query.users_by_genders,
      totalUserFeedbackByGender: @query.total_users_feedback_by_gender,
      ticketTracking: @query.ticket_tracking,
      overview: @query.goals
    })
  end

  private

  def summary_data
    {
      totalUserFeedback: @query.users_feedback,
      totalUserVisitByCategory: @query.total_users_visit_by_category
    }
  end

  def access_info_data
    {
      totalUserByGender: @query.users_by_genders,
      mostRequest: @query.most_requested_services,
      genderInfo: @query.gender_info,
      accessInfo: @query.access_info,
      accessMainService: @query.access_main_service,
      mostTrackedPeriodic: @query.most_tracked_periodic,
      ticketTrackingByGenders: @query.ticket_tracking_by_genders,
    }
  end

  def citizen_feedback_data
    {
      genderInfo: @query.gender_info,
      overallRating: @query.overall_rating,
      feedbackTrend: @query.feedback_trend,
      feedbackSubCategories: @query.feedback_sub_categories
    }
  end
end
