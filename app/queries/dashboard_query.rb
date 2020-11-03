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

  def user_unique_count
    user_unique.length
  end

  def user_unique
    sessions.select("DISTINCT ON (content_id, content_type) *").unscope(:order)
  end

  def unique_by_genders
    raw_sql = <<~SQL
      SELECT gender, COUNT(gender) AS gender_count FROM (
        #{ user_unique.to_sql }
      ) AS inner_query
      WHERE gender <> ''
      GROUP BY gender
      ORDER BY gender
    SQL

    Message.find_by_sql(raw_sql)
  end

  def sessions
    Message.filter(@options)
  end

  def total_users_visit_each_functions
    result = StepValue.total_users_visit_each_functions(@options)

    return {} if result.blank?

    default_chartjs_color_mapping.merge(result).transform_keys(&:humanize)
  end

  # prevent inconsistent chartjs color
  def default_chartjs_color_mapping
    return {} unless user_visit.present?

    default = {}
    key = "mapping_value_#{ I18n.locale }".to_sym
    user_visit.values.each { |val| default[val.send(key)] = 0 }
    default
  end

  def number_of_tracking_tickets
    result = Tracking.filter(@options).group(:status).count

    result.transform_keys { |k| I18n.t(k.downcase.to_sym) }
  end

  def total_users_feedback
    StepValue.total_users_feedback(@options)
  end

  def most_requested_service
    most_request_variable = Variable.most_request
    top_hit = most_request_variable.agg_values_count(@options).first
    most_request_variable.transform_key_result(*top_hit) if top_hit.present?
  end

  def total_requested_service
    Variable.most_request.agg_values_count(@options).values.sum
  end

  def goals
    @goals ||= [accessed, submitted].compact
  end

  def user_visit
    @user_visit ||= Variable.user_visit
  end

  def feedback
    @feedback ||= Variable.feedback
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
      data = accessed.group_by_day(:created_at).count

      { name: I18n.t("dashboard.accessed"), data: data, color: "#ffbc00", title: I18n.t("dashboard.accessed_explain"), class_name: "rect__accessed", display_text: I18n.t("dashboard.accessed") } if data.present?
    end

    # Ticket does not need to care about about platform(both, chatbot, ivr)
    # because it syncs from desktop app).
    def submitted
      data = Ticket.filter(@options).group_by_day(:requested_date).count

      { name: I18n.t("dashboard.submitted"), data: data, color: '#4e73df', title: I18n.t("dashboard.submitted_explain"), class_name: "rect__submitted", display_text: I18n.t("dashboard.submitted") } if data.present?
    end
end
