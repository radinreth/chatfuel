module DictionariesHelper
  def total_users_visit_each_functions
    Message
      .merge(send("join_#{@message_type}_message".to_sym))
      .joins(steps: { step_value: :variable_value })
      .where("variable_values.raw_value IN (?)", ["owso_info", "tracking", "feedback"])
      .where("DATE(step_values.created_at) BETWEEN ? AND ?", @start_date, @end_date)
      .order(:raw_value)
      .group(:raw_value)
      .count
  end

  def join_text_message
    Message\
      .joins("INNER JOIN text_messages ON text_messages.id=messages.content_id")\
      .where("text_messages.location_name=?", @location)
  end

  def join_voice_message
    Message\
      .joins("INNER JOIN voice_messages ON voice_messages.id=messages.content_id")
  end

  def join_both_message
    inner_query = Message\
          .merge(join_voice_message)\
          .joins("UNION SELECT messages.* FROM messages")\
          .merge(join_text_message)

    Message.unscoped.select("*").from(inner_query, :messages)
  end

  def total_users_feedback
    Message
      .merge(send("join_#{@message_type}_message".to_sym))
      .joins(steps: { step_value: { variable_value: :variable } })
      .where("variables.report_enabled=?", true)
      .where("DATE(step_values.created_at) BETWEEN ? AND ?", @start_date, @end_date)
      .group(:raw_value)
      .count
  end

  def number_of_tracking_tickets
    statuses = Ticket.statuses.fetch_values(:incomplete, :completed)

    Message
      .merge(send("join_#{@message_type}_message".to_sym))
      .joins(steps: { track: :ticket })
      .where("tickets.status IN (?)", statuses)
      .where("DATE(tracks.created_at) BETWEEN ? AND ?", @start_date, @end_date)
      .group(:status)
      .count
  end
end
