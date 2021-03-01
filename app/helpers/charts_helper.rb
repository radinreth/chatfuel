module ChartsHelper
  def locals
    {
      gender: {
        id: "total_user_gender",
        title: t("dashboard.total_user_gender")
      },
      total_user_visit: {
        id: "chart_total_user_visit",
        title: t("dashboard.total_user_visit")
      },
      feedback_by_gender: {
        id: "total_users_feedback_by_gender",
        title: t("dashboard.total_user_feedback_groupby_gender")
      },
      user_feedback: {
        id: "total_user_feedback",
        title: t("dashboard.total_user_feedback")
      },
      tracked_ticket: {
        id: "number_of_ticket_tracking",
        title: t("dashboard.number_of_ticket_tracking")
      },
      overview: {
        id: "chart-overview",
        title: t("dashboard.overview")
      },
      most_requested_services: {
        id: "chart_most_requested_services",
        title: t("welcomes.most_requested_services")
      },
      information_access: {
        id: "chart_information_access_by_period",
        title: t("welcomes.information_access_by")
      },
      main_services_access: {
        id: "chart_number_access_by_main_services",
        title: t("welcomes.number_access_by_main_services"),
      },
      service_tracked: {
        id: "chart_most_service_tracked_periodically",
        title: t("welcomes.most_service_tracked_by_periodic"),
      },
      ticket_tracking: {
        id: "chart_ticket_tracking_by_gender",
        title: t("welcomes.ticket_tracking_by_gender"),
      },
      access_by_gender: {
        id: "gender_feedback",
        title: t("welcomes.information_access_by_gender"),
      },
      overall_rating: {
        id: "chart_overall_rating_by_owso",
        title: t("welcomes.overall_rating_by_owso"),
      },
      feedback_trend: {
        id: "chart_owso_feedback_trend",
        title: t("welcomes.owso_feedback_trend"),
      },
      sub_categories: {
        id: "chart_feedback_by_sub_category",
        title: t("welcomes.feedback_by_sub_categories", name: @location_filter.province_name),
      }
    }
  end
end