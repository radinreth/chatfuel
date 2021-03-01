module DashboardHelper
  def subheader
    return "" if @criteria.nil?

    content_tag :span, class: "" do
      "#{@criteria.variable_name} " \
      " &raquo; #{@criteria.mapping_value}".html_safe
    end
  end

  def open_config_modal(target)
    if policy(:dashboard).setting?
      link_to "#", class: "ml-2", data: { toggle: "modal", target: target } do
        content_tag :i, nil, class: "fas fa-cog cog"
      end
    end
  end

  def locals
    {
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
