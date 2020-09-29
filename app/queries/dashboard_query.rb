class DashboardQuery
  def initialize(options = {})
    @options = options
    platform = platform_param[@options[:platform].try(:to_sym)]
    @options[:platform_name] = ["Messenger", "Telegram", "Verboice"]
    @options.merge!(platform) if platform.present?
  end

  def user_count
    sessions.count
  end

  def user_uniq_count
    sessions.select("DISTINCT ON (content_id, content_type) *").unscope(:order).length
  end

  def sessions
    Message.filter(@options)
  end

  def total_users_visit_each_functions
    result = StepValue.total_users_visit_each_functions(@options)

    return {} if result.blank?

    default_chartjs_color_mapping.merge(result)
  end

  # prevent inconsistent chartjs color
  def default_chartjs_color_mapping
    return {} unless user_visit.present?

    default = {}
    user_visit.values.each { |val| default[val.mapping_value] = 0 }
    default
  end

  def number_of_tracking_tickets
    num_tracking = StepValue.number_of_tracking_tickets(@options)
    num_tracking.delete('paid')
    # sort hash by order in array of ticket status
    num_tracking.slice(*Ticket::STATUSES)
  end

  def total_users_feedback
    StepValue.total_users_feedback(@options)
  end

  def most_request_service
    StepValue.most_request_service(@options)
  end

  def goals
    @goals ||= [accessed, submitted].compact
  end

  def user_visit
    @user_visit ||= Variable.find_by(is_user_visit: true)
  end

  def report_enabled
    @report_enabled ||= Variable.find_by(report_enabled: true)
  end

  private
    def platform_param
      {
        ivr: { platform_name: ["Verboice"], content_type: 'VoiceMessage' },
        chatbot: { platform_name: ["Messenger", "Telegram"], content_type: 'TextMessage' }
      }
    end

    def accessed
      accessed = Message.unscope(:order).accessed(@options)

      return {} unless accessed
      data = accessed.group_by_day(:updated_at).count

      { name: I18n.t("dashboard.accessed"), data: data, color: '#ffbc00', title: I18n.t("dashboard.accessed_explain"), class_name: "rect__accessed", display_text: I18n.t("dashboard.accessed") } if data.present?
    end

    # Ticket does not need to care about about platform(both, chatbot, ivr)
    # because it syncs from desktop app).
    def submitted
      data = Ticket.filter(@options).group_by_day(:requested_date).count

      { name: I18n.t("dashboard.submitted"), data: data, color: '#4e73df', title: I18n.t("dashboard.submitted_explain"), class_name: "rect__submitted", display_text: I18n.t("dashboard.submitted") } if data.present?
    end
end
