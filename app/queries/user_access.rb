class UserAccess < BasicReport
  def dataset
    [
      accessed,
      submitted_ticket_in_kamrieng,
      submitted_ticket_in_poipet
    ].compact
  end

  private

    # TODO: move site code to setting
    # mark_as: service_accessed( variable = owso_info )
    def accessed
      accessed = Session.unscope(:order).accessed(@query.options)

      return {} unless accessed
      data = accessed.group_by_day(:created_at, format: "%b %e, %y").count

      { name: I18n.t("dashboard.accessed"), data: data, color: "#ffbc00", title: I18n.t("dashboard.accessed_explain"), class_name: "rect__accessed", display_text: I18n.t("dashboard.accessed") } if data.present?
    end

    # Ticket does not need to care about about platform(both, chatbot, ivr)
    # because it syncs from desktop app).
    def submitted_ticket_in_kamrieng
      # .for_location("0212")
      data = Ticket.filter(@query.options).group_by_day(:requested_date, format: "%b %e, %y").count

      { name: I18n.t("dashboard.submitted", site_name: I18n.t("sites.kamrieng")), data: data, color: '#4e73df', title: I18n.t("dashboard.submitted_explain", site_name: I18n.t("sites.kamrieng")), class_name: "rect__submitted", display_text: I18n.t("dashboard.submitted", site_name: I18n.t("sites.kamrieng")) } if data.present?
    end

    def submitted_ticket_in_poipet
      data = Ticket.filter(@query.options).for_location("0110").group_by_day(:requested_date, format: "%b %e, %y").count

      { name: I18n.t("dashboard.submitted", site_name: I18n.t("sites.poipet")), data: data, color: '#673AB7', title: I18n.t("dashboard.submitted_explain", site_name: I18n.t("sites.poipet")), class_name: "rect__submitted", display_text: I18n.t("dashboard.submitted", site_name: I18n.t("sites.poipet")) } if data.present?
    end
end